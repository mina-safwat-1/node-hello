// eslint.config.js
const js = require("@eslint/js");
export default [
  js.configs.recommended,
  {
    rules: {
      semi: "error",          // require semicolons
      quotes: ["error", "double"], // enforce double quotes
      "no-unused-vars": "warn",    // warn about unused vars
    },
  },
];
