import { test } from "node:test";
import assert from "node:assert/strict";

import {
  ContactPayloadValidationError,
  parseContactPayload,
} from "./contact_payload";

test("parses and trims a valid contact payload", () => {
  assert.deepEqual(
    parseContactPayload({
      name: "  Test User  ",
      email: "  user@example.com  ",
      subject: "  App consultation  ",
      message: "  Please help with my Flutter app.  ",
    }),
    {
      name: "Test User",
      email: "user@example.com",
      subject: "App consultation",
      message: "Please help with my Flutter app.",
    },
  );
});

test("rejects unknown fields", () => {
  assert.throws(
    () =>
      parseContactPayload({
        name: "Test User",
        email: "user@example.com",
        subject: "Subject",
        message: "Message",
        status: "approved",
      }),
    ContactPayloadValidationError,
  );
});

test("rejects invalid email and oversized text", () => {
  assert.throws(
    () =>
      parseContactPayload({
        name: "Test User",
        email: "invalid-email",
        subject: "Subject",
        message: "Message",
      }),
    ContactPayloadValidationError,
  );
  assert.throws(
    () =>
      parseContactPayload({
        name: "x".repeat(51),
        email: "user@example.com",
        subject: "Subject",
        message: "Message",
      }),
    ContactPayloadValidationError,
  );
});
