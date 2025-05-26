// This is a redirect file for Render deployment
// Render seems to be looking for app.js in the root directory
// So we're redirecting to the actual compiled file in dist/app.js

require('./dist/app.js');
