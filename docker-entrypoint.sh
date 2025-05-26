#!/bin/sh
set -e

# Log environment for debugging (redact sensitive info)
echo "Starting in environment: $NODE_ENV"
echo "Database: $(echo $DATABASE_URL | sed 's/postgresql:\/\/[^:]*:[^@]*@/postgresql:\/\/user:password@/')"

# Run database migrations
echo "Running database migrations..."
npx prisma migrate deploy

# Start the application
echo "Starting application..."
exec node dist/app.js
