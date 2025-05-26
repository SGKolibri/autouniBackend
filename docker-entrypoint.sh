#!/bin/bash
set -e

# Print version information for debugging
echo "Node version: $(node -v)"
echo "NPM version: $(npm -v)"

# Log environment for debugging (redact sensitive info)
echo "Starting in environment: $NODE_ENV"

if [ -n "$DATABASE_URL" ]; then
  echo "Database connection is configured"
  
  # Run database migrations if DATABASE_URL is provided
  echo "Running database migrations..."
  /usr/local/bin/npx prisma migrate deploy
else
  echo "WARNING: DATABASE_URL is not set. Skipping migrations."
fi

# Start the application
echo "Starting application..."
exec node dist/app.js
