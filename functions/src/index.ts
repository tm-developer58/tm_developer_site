import { createHmac } from "node:crypto";

import { initializeApp } from "firebase-admin/app";
import {
  FieldValue,
  getFirestore,
  Timestamp,
  type DocumentReference,
} from "firebase-admin/firestore";
import { logger } from "firebase-functions";
import { defineSecret } from "firebase-functions/params";
import { HttpsError, onCall } from "firebase-functions/v2/https";
import nodemailer from "nodemailer";

import {
  ContactPayloadValidationError,
  parseContactPayload,
  type ContactPayload,
} from "./contact_payload";
import { calculateRateLimit, type RateLimitState } from "./rate_limit";

initializeApp();

const db = getFirestore();
const gmailAppPassword = defineSecret("GMAIL_APP_PASSWORD");
const rateLimitPepper = defineSecret("CONTACT_RATE_LIMIT_PEPPER");

const region = "asia-northeast1";
const notificationEmail = "tm.developer58@gmail.com";
const rateLimitCollection = "contactRateLimits";
const contactCollection = "contactMessages";
const rateLimitRetentionMs = 24 * 60 * 60 * 1000;

export const submitContactMessage = onCall(
  {
    region,
    enforceAppCheck: true,
    secrets: [gmailAppPassword, rateLimitPepper],
    timeoutSeconds: 60,
    memory: "256MiB",
    maxInstances: 10,
    cors: [
      "https://tm-developer-site.web.app",
      "https://tm-developer-site.firebaseapp.com",
      /^http:\/\/(localhost|127\.0\.0\.1)(:\d+)?$/,
    ],
  },
  async (request) => {
    let payload: ContactPayload;
    try {
      payload = parseContactPayload(request.data);
    } catch (error) {
      if (error instanceof ContactPayloadValidationError) {
        throw new HttpsError("invalid-argument", "invalid-contact-payload");
      }
      throw error;
    }

    const clientIp =
      request.rawRequest.ip ?? request.rawRequest.socket.remoteAddress;
    if (clientIp == null || clientIp.trim().length === 0) {
      logger.error("Contact submission did not include a client address");
      throw new HttpsError("internal", "client-address-unavailable");
    }

    const nowMs = Date.now();
    const limiterId = createHmac("sha256", rateLimitPepper.value())
      .update(clientIp.trim())
      .digest("hex");
    const limiterRef = db.collection(rateLimitCollection).doc(limiterId);
    const messageRef = db.collection(contactCollection).doc();

    await db.runTransaction(async (transaction) => {
      const limiterSnapshot = await transaction.get(limiterRef);
      const current = limiterSnapshot.exists
        ? readRateLimitState(limiterSnapshot.data() ?? {})
        : undefined;
      const result = calculateRateLimit(current, nowMs);

      if (!result.allowed) {
        throw new HttpsError("resource-exhausted", "contact-rate-limited", {
          retryAfterSeconds: result.retryAfterSeconds,
        });
      }

      transaction.set(limiterRef, {
        shortWindowStartedAt: Timestamp.fromMillis(
          result.next.shortWindowStartedAtMs,
        ),
        shortWindowCount: result.next.shortWindowCount,
        dailyWindowStartedAt: Timestamp.fromMillis(
          result.next.dailyWindowStartedAtMs,
        ),
        dailyWindowCount: result.next.dailyWindowCount,
        expiresAt: Timestamp.fromMillis(nowMs + rateLimitRetentionMs),
        updatedAt: FieldValue.serverTimestamp(),
      });
      transaction.set(messageRef, {
        ...payload,
        createdAt: FieldValue.serverTimestamp(),
        status: "new",
        source: "contact_form",
        notificationStatus: "pending",
      });
    });

    await sendNotification(messageRef, payload);
    return { success: true };
  },
);

function readRateLimitState(
  data: Record<string, unknown>,
): RateLimitState | undefined {
  const shortWindowStartedAt = data.shortWindowStartedAt;
  const dailyWindowStartedAt = data.dailyWindowStartedAt;
  const shortWindowCount = data.shortWindowCount;
  const dailyWindowCount = data.dailyWindowCount;

  if (
    !(shortWindowStartedAt instanceof Timestamp) ||
    !(dailyWindowStartedAt instanceof Timestamp) ||
    typeof shortWindowCount !== "number" ||
    typeof dailyWindowCount !== "number"
  ) {
    return undefined;
  }

  return {
    shortWindowStartedAtMs: shortWindowStartedAt.toMillis(),
    shortWindowCount,
    dailyWindowStartedAtMs: dailyWindowStartedAt.toMillis(),
    dailyWindowCount,
  };
}

async function sendNotification(
  messageRef: DocumentReference,
  payload: ContactPayload,
): Promise<void> {
  const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
      user: notificationEmail,
      pass: gmailAppPassword.value(),
    },
  });

  try {
    await transporter.sendMail({
      from: `TM Developer <${notificationEmail}>`,
      to: notificationEmail,
      replyTo: payload.email,
      subject: `[TM Developer] ${sanitizeHeader(payload.subject)}`,
      text: [
        "TM Developerサイトから問い合わせが届きました。",
        "",
        `名前: ${payload.name}`,
        `メール: ${payload.email}`,
        `件名: ${payload.subject}`,
        "",
        "本文:",
        payload.message,
        "",
        `Firestore document: ${messageRef.id}`,
      ].join("\n"),
    });
    await messageRef.update({
      notificationStatus: "sent",
      notificationSentAt: FieldValue.serverTimestamp(),
    });
  } catch (error) {
    logger.error("Contact notification email failed", {
      messageId: messageRef.id,
      errorName: error instanceof Error ? error.name : "unknown",
    });
    try {
      await messageRef.update({ notificationStatus: "failed" });
    } catch (updateError) {
      logger.error("Failed to record contact notification status", {
        messageId: messageRef.id,
        errorName: updateError instanceof Error ? updateError.name : "unknown",
      });
    }
  }
}

function sanitizeHeader(value: string): string {
  return value.replace(/[\r\n]+/g, " ").trim();
}
