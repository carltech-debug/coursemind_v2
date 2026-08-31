export interface VerificationSession {
  readonly sessionId: string;
  readonly emailHash: string;
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

export interface VerifyCodeRequest {
  readonly verificationSessionId: string;
  readonly code: string;
}

export interface VerifyCodeResponse {
  readonly verified: boolean;
}
