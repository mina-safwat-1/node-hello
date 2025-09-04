// eslint.config.cjs
const js = require("@eslint/js");
const globals = require("globals");

module.exports = [
  js.configs.recommended,
  {
    languageOptions: {
      globals: {
        ...globals.node,   // enable ALL Node.js globals
        ...globals.es2021, // enable modern JS globals
      },
    },
    rules: {
      semi: "warn",                // warn instead of error
      quotes: ["warn", "double"],  // warn instead of error
      "no-unused-vars": "warn",    // warn
    },
  },
];
