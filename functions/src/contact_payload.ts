export interface ContactPayload {
  name: string;
  email: string;
  subject: string;
  message: string;
}

export class ContactPayloadValidationError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "ContactPayloadValidationError";
  }
}

const allowedKeys = new Set(["name", "email", "subject", "message"]);
const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

export function parseContactPayload(data: unknown): ContactPayload {
  if (!isRecord(data)) {
    throw new ContactPayloadValidationError("payload must be an object");
  }

  if (Object.keys(data).some((key) => !allowedKeys.has(key))) {
    throw new ContactPayloadValidationError("payload contains unknown fields");
  }

  const name = readText(data, "name", 50);
  const email = readText(data, "email", 100);
  const subject = readText(data, "subject", 100);
  const message = readText(data, "message", 1000);

  if (!emailPattern.test(email)) {
    throw new ContactPayloadValidationError("email is invalid");
  }

  return { name, email, subject, message };
}

function readText(
  data: Record<string, unknown>,
  key: string,
  maxLength: number,
): string {
  const value = data[key];
  if (typeof value !== "string") {
    throw new ContactPayloadValidationError(`${key} must be a string`);
  }

  const trimmed = value.trim();
  if (trimmed.length === 0 || trimmed.length > maxLength) {
    throw new ContactPayloadValidationError(`${key} has an invalid length`);
  }
  return trimmed;
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}
