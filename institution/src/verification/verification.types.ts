export interface VerificationSession {
  readonly sessionId: string;
  readonly emailHash: string;
  readonly otpHash: string;
  readonly expiresAt: number;
  readonly attempts: number;
  readonly status: "pending" | "verified" | "expired" | "locked";
}

export interface StartVerificationRequest {
  readonly email: string;
}

export interface StartVerificationResponse {
  readonly verificationSessionId: string;
  readonly expiresIn: number;
}

/**
 * Internal result used by the email-delivery layer.
 *
 * This type must never be returned from a callable function because it
 * contains the plaintext OTP needed only to compose the verification email.
 */
export interface StartVerificationResult {
  readonly response: StartVerificationResponse;
  readonly otp: string;
}

export interface VerifyCodeRequest {
  readonly verificationSessionId: string;
  readonly code: string;
}

export interface VerifyCodeResponse {
  readonly verified: boolean;
}
