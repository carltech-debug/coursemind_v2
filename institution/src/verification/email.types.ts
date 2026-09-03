export interface VerificationEmail {
  readonly recipientEmail: string;
  readonly otp: string;
  readonly expiresIn: number;
}

export interface VerificationEmailService {
  sendVerificationCode(
    email: VerificationEmail,
  ): Promise<void>;
}
