import {createHash, randomUUID} from "node:crypto";

import {VerificationEmailService} from "./email.types";
import {generateOtp} from "./otp";
import {VerificationSessionRepository} from "./verification.repository";
import {
  StartVerificationRequest,
  StartVerificationResult,
  VerificationSession,
} from "./verification.types";

const VERIFICATION_SESSION_DURATION_MS = 10 * 60 * 1000;

export {VERIFICATION_SESSION_DURATION_MS};

/**
 * Creates a SHA-256 hash for sensitive verification data.
 *
 * @param {string} value Value to hash.
 * @return {string} SHA-256 hash.
 */
function hashValue(value: string): string {
  return createHash("sha256").update(value).digest("hex");
}

/**
 * Normalizes an email address before it is used by the verification system.
 *
 * @param {string} email Administrator email address.
 * @return {string} Normalized email address.
 */
function normalizeEmail(email: string): string {
  return email.trim().toLowerCase();
}

/**
 * Validates the basic shape of an administrator email address.
 *
 * @param {string} email Normalized administrator email address.
 * @return {boolean} Whether the email has a valid basic shape.
 */
function isValidEmail(email: string): boolean {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

/**
 * Creates a new verification session.
 *
 * The generated OTP is never stored in plaintext.
 * The plaintext OTP is returned only so the email-delivery
 * layer can send it to the administrator.
 *
 * @param {string} email Administrator email address.
 * @param {number} now Current time in milliseconds since the Unix epoch.
 * @return {object} Verification session and generated OTP.
 */
export function createVerificationSession(
  email: string,
  now: number = Date.now(),
): {
  readonly session: VerificationSession;
  readonly otp: string;
} {
  const normalizedEmail = normalizeEmail(email);

  if (!normalizedEmail) {
    throw new Error("Email is required.");
  }

  const sessionId = randomUUID();
  const otp = generateOtp();
  const expiresAt = now + VERIFICATION_SESSION_DURATION_MS;

  const session: VerificationSession = {
    sessionId,
    emailHash: hashValue(normalizedEmail),
    otpHash: hashValue(otp),
    expiresAt,
    attempts: 0,
    status: "pending",
  };

  return {
    session,
    otp,
  };
}

/**
 * Determines whether a verification session has passed its expiry time.
 *
 * @param {VerificationSession} session Verification session to inspect.
 * @param {number} now Current time in milliseconds since the Unix epoch.
 * @return {boolean} Whether the session has expired.
 */
export function isVerificationSessionExpired(
  session: VerificationSession,
  now: number = Date.now(),
): boolean {
  return now >= session.expiresAt;
}

/**
 * Creates and persists a verification session for an administrator email.
 *
 * The generated OTP is then passed to the email-delivery layer.
 * The OTP is never included in the public response.
 *
 * @param {StartVerificationRequest} request Start verification request.
 * @param {VerificationSessionRepository} repository Session persistence layer.
 * @param {VerificationEmailService} emailService Email delivery service.
 * @return {Promise<StartVerificationResult>} Internal verification result.
 */
export async function startVerification(
  request: StartVerificationRequest,
  repository: VerificationSessionRepository,
  emailService: VerificationEmailService,
): Promise<StartVerificationResult> {
  const normalizedEmail = normalizeEmail(request.email);

  if (!isValidEmail(normalizedEmail)) {
    throw new Error("A valid email is required.");
  }

  const {session, otp} = createVerificationSession(
    normalizedEmail,
  );

  await repository.create(session);

  await emailService.sendVerificationCode({
    recipientEmail: normalizedEmail,
    otp,
    expiresIn: VERIFICATION_SESSION_DURATION_MS / 1_000,
  });

  return {
    response: {
      verificationSessionId: session.sessionId,
      expiresIn: VERIFICATION_SESSION_DURATION_MS / 1_000,
    },
    otp,
  };
}
