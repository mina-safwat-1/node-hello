// eslint.config.cjs
const js = require("@eslint/js");

module.exports = [
  js.configs.recommended,
  {
    rules: {
      semi: "error",               // enforce semicolons
      quotes: ["error", "double"], // enforce double quotes
      "no-unused-vars": "warn",    // warn about unused vars
    },
  },
];
