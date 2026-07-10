export const shortWindowMs = 10 * 60 * 1000;
export const dailyWindowMs = 24 * 60 * 60 * 1000;
export const shortWindowLimit = 3;
export const dailyWindowLimit = 10;

export interface RateLimitState {
  shortWindowStartedAtMs: number;
  shortWindowCount: number;
  dailyWindowStartedAtMs: number;
  dailyWindowCount: number;
}

export type RateLimitResult =
  | { allowed: true; next: RateLimitState }
  | { allowed: false; retryAfterSeconds: number };

export function calculateRateLimit(
  current: RateLimitState | undefined,
  nowMs: number,
): RateLimitResult {
  const shortWindow = activeWindow(
    current?.shortWindowStartedAtMs,
    current?.shortWindowCount,
    nowMs,
    shortWindowMs,
  );
  const dailyWindow = activeWindow(
    current?.dailyWindowStartedAtMs,
    current?.dailyWindowCount,
    nowMs,
    dailyWindowMs,
  );

  const retryAt: number[] = [];
  if (shortWindow.count >= shortWindowLimit) {
    retryAt.push(shortWindow.startedAtMs + shortWindowMs);
  }
  if (dailyWindow.count >= dailyWindowLimit) {
    retryAt.push(dailyWindow.startedAtMs + dailyWindowMs);
  }

  if (retryAt.length > 0) {
    const retryAfterMs = Math.max(...retryAt) - nowMs;
    return {
      allowed: false,
      retryAfterSeconds: Math.max(1, Math.ceil(retryAfterMs / 1000)),
    };
  }

  return {
    allowed: true,
    next: {
      shortWindowStartedAtMs: shortWindow.startedAtMs,
      shortWindowCount: shortWindow.count + 1,
      dailyWindowStartedAtMs: dailyWindow.startedAtMs,
      dailyWindowCount: dailyWindow.count + 1,
    },
  };
}

function activeWindow(
  startedAtMs: number | undefined,
  count: number | undefined,
  nowMs: number,
  durationMs: number,
): { startedAtMs: number; count: number } {
  if (
    startedAtMs == null ||
    count == null ||
    startedAtMs > nowMs ||
    nowMs - startedAtMs >= durationMs
  ) {
    return { startedAtMs: nowMs, count: 0 };
  }
  return { startedAtMs, count: Math.max(0, count) };
}
