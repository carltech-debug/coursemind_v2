import {beforeEach, describe, expect, it, jest} from "@jest/globals";

const sendMailMock = jest.fn(
  (...args: unknown[]) => {
    void args;

    return Promise.resolve({
      messageId: "test-message-id",
    });
  },
);

jest.mock("nodemailer", () => ({
  createTransport: jest.fn(() => ({
    sendMail: sendMailMock,
  })),
}));

import {
  createGmailVerificationEmailService,
} from "../../src/verification/email.service";

describe("createGmailVerificationEmailService", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it("creates a verification email service", () => {
    const service =
      createGmailVerificationEmailService();

    expect(service.sendVerificationCode).toEqual(
      expect.any(Function),
    );
  });

  it("sends a verification email through Gmail SMTP", async () => {
    const service =
      createGmailVerificationEmailService();

    await service.sendVerificationCode({
      recipientEmail: "admin@example.com",
      otp: "123456",
      expiresIn: 600,
    });

    expect(sendMailMock).toHaveBeenCalledTimes(1);

    expect(sendMailMock).toHaveBeenCalledWith(
      expect.objectContaining({
        to: "admin@example.com",
        subject:
          "CourseMind Institution Verification Code",
        text: expect.stringContaining("123456"),
      }),
    );
  });

  it("includes the verification expiry time", async () => {
    const service =
      createGmailVerificationEmailService();

    await service.sendVerificationCode({
      recipientEmail: "admin@example.com",
      otp: "654321",
      expiresIn: 600,
    });

    const mailOptions =
      sendMailMock.mock.calls[0][0] as {
        text: string;
      };

    expect(mailOptions.text).toContain(
      "10 minutes",
    );
  });

  it("propagates email delivery failures", async () => {
    sendMailMock.mockRejectedValueOnce(
      new Error("SMTP delivery failed."),
    );

    const service =
      createGmailVerificationEmailService();

    await expect(
      service.sendVerificationCode({
        recipientEmail: "admin@example.com",
        otp: "123456",
        expiresIn: 600,
      }),
    ).rejects.toThrow("SMTP delivery failed.");
  });
});
