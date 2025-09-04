// eslint.config.cjs
const js = require("@eslint/js");

module.exports = [
  js.configs.recommended,
  {
    rules: {
      semi: "warn",                // warn about missing semicolons
      quotes: ["warn", "double"],  // warn about single quotes
      "no-unused-vars": "warn",    // keep this as warning
    },
  },
];
