import * as dotenv from "dotenv";
import * as nodemailer from "nodemailer";

import {
  VerificationEmail,
  VerificationEmailService,
} from "./email.types";

dotenv.config();

const smtpEmail = process.env.COURSEMIND_EMAIL;
const smtpPassword = process.env.COURSEMIND_EMAIL_PASSWORD;

if (!smtpEmail || !smtpPassword) {
  throw new Error(
    "CourseMind email credentials are not configured.",
  );
}

const transporter = nodemailer.createTransport({
  host: "smtp.gmail.com",
  port: 465,
  secure: true,
  auth: {
    user: smtpEmail,
    pass: smtpPassword,
  },
});

/**
 * Creates a Gmail SMTP verification email service.
 *
 * This service sends administrator verification codes through
 * the dedicated CourseMind development Gmail account.
 *
 * @return {VerificationEmailService} Gmail SMTP email service.
 */
export function createGmailVerificationEmailService():
  VerificationEmailService {
  return {
    async sendVerificationCode(
      email: VerificationEmail,
    ): Promise<void> {
      await transporter.sendMail({
        from: smtpEmail,
        to: email.recipientEmail,
        subject: "CourseMind Institution Verification Code",
        text: [
          "CourseMind Institution Registration",
          "",
          `Your verification code is: ${email.otp}`,
          "",
          `This code expires in ${Math.floor(
            email.expiresIn / 60,
          )} minutes.`,
          "",
          "If you did not request this code, you can ignore this email.",
        ].join("\n"),
      });
    },
  };
}
