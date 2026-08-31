import {randomInt} from "node:crypto";

const OTP_LENGTH = 6;

/**
 * Generates a cryptographically secure six-digit OTP.
 *
 * @return {string} A six-digit numeric OTP.
 */
export function generateOtp(): string {
  return randomInt(0, 1_000_000)
    .toString()
    .padStart(OTP_LENGTH, "0");
}
