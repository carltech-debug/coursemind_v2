import {createHash, randomUUID} from "node:crypto";

import {VerificationEmailService} from "./email.types";
import {generateOtp} from "./otp";
import {VerificationSessionRepository} from "./verification.repository";
import {
  StartVerificationRequest,
  StartVerificationResult,
  ResendVerificationRequest,
  ResendVerificationResult,
  VerificationSession,
  VerifyCodeRequest,
  VerifyCodeResponse,
} from "./verification.types";

const VERIFICATION_SESSION_DURATION_MS = 10 * 60 * 1000;
const MAX_VERIFICATION_ATTEMPTS = 5;
const RESEND_COOLDOWN_MS = 60 * 1000;

export {
  MAX_VERIFICATION_ATTEMPTS,
  RESEND_COOLDOWN_MS,
  VERIFICATION_SESSION_DURATION_MS,
};

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
    resendCount: 0,
    lastSentAt: now,
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

/**
 * Verifies an administrator OTP against a stored verification session.
 *
 * The submitted OTP is hashed before comparison and is never persisted.
 *
 * @param {VerifyCodeRequest} request Verification request.
 * @param {VerificationSessionRepository} repository Session repository.
 * @param {number} now Current time in milliseconds since the Unix epoch.
 * @return {Promise<VerifyCodeResponse>} Verification result.
 */
export async function verifyCode(
  request: VerifyCodeRequest,
  repository: VerificationSessionRepository,
  now: number = Date.now(),
): Promise<VerifyCodeResponse> {
  const session = await repository.get(
    request.verificationSessionId,
  );

  if (!session) {
    throw new Error("Verification session not found.");
  }

  if (session.status !== "pending") {
    return {
      verified: session.status === "verified",
    };
  }

  if (isVerificationSessionExpired(session, now)) {
    const expiredSession: VerificationSession = {
      ...session,
      status: "expired",
    };

    await repository.update(expiredSession);

    return {
      verified: false,
    };
  }

  const submittedCodeHash = hashValue(
    request.code.trim(),
  );

  if (submittedCodeHash !== session.otpHash) {
    const attempts = session.attempts + 1;
    const failedSession: VerificationSession = {
      ...session,
      attempts,
      status: attempts >= MAX_VERIFICATION_ATTEMPTS ?
        "locked" :
        "pending",
    };

    await repository.update(failedSession);

    return {
      verified: false,
    };
  }

  const verifiedSession: VerificationSession = {
    ...session,
    status: "verified",
  };

  await repository.update(verifiedSession);

  return {
    verified: true,
  };
}

/**
 * Sends a replacement OTP for an existing verification session.
 *
 * The supplied email is hashed and compared with the stored email hash before
 * it is used as the email destination. The email itself is never persisted.
 *
 * @param {ResendVerificationRequest} request Resend verification request.
 * @param {VerificationSessionRepository} repository Session repository.
 * @param {VerificationEmailService} emailService Email delivery service.
 * @param {number} now Current time in milliseconds since the Unix epoch.
 * @return {Promise<ResendVerificationResult>} Public result and email OTP.
 */
export async function resendVerification(
  request: ResendVerificationRequest,
  repository: VerificationSessionRepository,
  emailService: VerificationEmailService,
  now: number = Date.now(),
): Promise<ResendVerificationResult> {
  const session = await repository.get(
    request.verificationSessionId,
  );

  if (!session) {
    throw new Error("Verification session not found.");
  }

  const normalizedEmail = normalizeEmail(request.email);
  if (!isValidEmail(normalizedEmail) ||
      hashValue(normalizedEmail) !== session.emailHash) {
    throw new Error("Verification email does not match the session.");
  }

  if (session.status !== "pending") {
    throw new Error("Verification session is not pending.");
  }

  if (isVerificationSessionExpired(session, now)) {
    await repository.update({
      ...session,
      status: "expired",
    });
    throw new Error("Verification session has expired.");
  }

  const resendAvailableAt = session.lastSentAt +
    RESEND_COOLDOWN_MS;
  if (now < resendAvailableAt) {
    throw new Error("Verification resend is on cooldown.");
  }

  const otp = generateOtp();
  const updatedSession: VerificationSession = {
    ...session,
    otpHash: hashValue(otp),
    attempts: 0,
    resendCount: session.resendCount + 1,
    lastSentAt: now,
  };

  await repository.update(updatedSession);

  const expiresIn = Math.ceil(
    (session.expiresAt - now) / 1_000,
  );
  await emailService.sendVerificationCode({
    recipientEmail: normalizedEmail,
    otp,
    expiresIn,
  });

  return {
    response: {
      verificationSessionId: session.sessionId,
      expiresIn,
      resendAvailableIn: RESEND_COOLDOWN_MS / 1_000,
    },
    otp,
  };
}
