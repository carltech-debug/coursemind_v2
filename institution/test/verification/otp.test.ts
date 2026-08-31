import {describe, expect, it} from "@jest/globals";

import {generateOtp} from "../../src/verification/otp";

describe("generateOtp", () => {
  it("returns a string", () => {
    expect(typeof generateOtp()).toBe("string");
  });

  it("returns exactly six digits", () => {
    const otp = generateOtp();

    expect(otp).toMatch(/^\d{6}$/);
  });

  it("returns a value between 000000 and 999999", () => {
    const otp = generateOtp();
    const numericOtp = Number(otp);

    expect(numericOtp).toBeGreaterThanOrEqual(0);
    expect(numericOtp).toBeLessThanOrEqual(999999);
  });

  it("preserves six-digit formatting", () => {
    for (let i = 0; i < 100; i++) {
      expect(generateOtp()).toMatch(/^\d{6}$/);
    }
  });
});
