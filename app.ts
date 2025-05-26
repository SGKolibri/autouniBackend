// This is a redirect file for Render deployment
// Render seems to be looking for app.ts in the root directory
// So we're redirecting to the actual file in src/app.ts

require("./src/app.ts");
