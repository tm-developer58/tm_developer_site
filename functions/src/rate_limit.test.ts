import { test } from "node:test";
import assert from "node:assert/strict";

import {
  calculateRateLimit,
  dailyWindowMs,
  type RateLimitState,
  shortWindowMs,
} from "./rate_limit";

const now = Date.UTC(2026, 6, 10, 0, 0, 0);

test("allows the first submission and starts both windows", () => {
  assert.deepEqual(calculateRateLimit(undefined, now), {
    allowed: true,
    next: {
      shortWindowStartedAtMs: now,
      shortWindowCount: 1,
      dailyWindowStartedAtMs: now,
      dailyWindowCount: 1,
    },
  });
});

test("blocks the fourth submission inside ten minutes", () => {
  const state: RateLimitState = {
    shortWindowStartedAtMs: now,
    shortWindowCount: 3,
    dailyWindowStartedAtMs: now,
    dailyWindowCount: 3,
  };

  assert.deepEqual(calculateRateLimit(state, now + 60_000), {
    allowed: false,
    retryAfterSeconds: 9 * 60,
  });
});

test("blocks the eleventh submission inside twenty-four hours", () => {
  const state: RateLimitState = {
    shortWindowStartedAtMs: now - shortWindowMs,
    shortWindowCount: 3,
    dailyWindowStartedAtMs: now,
    dailyWindowCount: 10,
  };

  assert.deepEqual(calculateRateLimit(state, now + 60_000), {
    allowed: false,
    retryAfterSeconds: 24 * 60 * 60 - 60,
  });
});

test("resets expired windows", () => {
  const state: RateLimitState = {
    shortWindowStartedAtMs: now - shortWindowMs,
    shortWindowCount: 3,
    dailyWindowStartedAtMs: now - dailyWindowMs,
    dailyWindowCount: 10,
  };

  assert.deepEqual(calculateRateLimit(state, now), {
    allowed: true,
    next: {
      shortWindowStartedAtMs: now,
      shortWindowCount: 1,
      dailyWindowStartedAtMs: now,
      dailyWindowCount: 1,
    },
  });
});
