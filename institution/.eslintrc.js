module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
    jest: true,
  },
  extends: [
    "eslint:recommended",
    "plugin:import/errors",
    "plugin:import/warnings",
    "plugin:import/typescript",
    "google",
    "plugin:@typescript-eslint/recommended",
  ],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    project: ["./tsconfig.json", "./tsconfig.test.json"],
    tsconfigRootDir: __dirname,
    sourceType: "module",
  },
  ignorePatterns: [
    "/lib/**/*",
    "/generated/**/*",
    ".eslintrc.js",
    "jest.config.js",
  ],
  plugins: [
    "@typescript-eslint",
    "import",
  ],
  overrides: [
    {
      files: ["jest.config.js"],
      parserOptions: {
        project: null,
      },
    },
  ],
  rules: {
    "quotes": ["error", "double"],
    "import/no-unresolved": 0,
    "indent": ["error", 2],
  },
};