// eslint.config.cjs
const js = require("@eslint/js");

module.exports = [
  js.configs.recommended,
  {
    languageOptions: {
      env: {
        node: true, // Enables ALL Node.js globals (require, module, process, console, etc.)
        es2021: true, // Enables modern JS globals (Promise, globalThis, etc.)
      },
    },
    rules: {
      semi: "warn",                // just warn
      quotes: ["warn", "double"],  // just warn
      "no-unused-vars": "warn",    // just warn
    },
  },
];
