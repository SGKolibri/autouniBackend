# Simplified Dockerfile for Render deployment
FROM node:18-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    python3 \
    build-essential \
    openssl \
    dos2unix \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Copy package files
COPY package.json ./
COPY package-lock.json* ./
RUN npm install

# Generate Prisma client
COPY prisma ./prisma/
RUN npx prisma generate

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Fix entrypoint script
RUN dos2unix ./docker-entrypoint.sh && \
    chmod +x ./docker-entrypoint.sh

# Set environment variables
ENV NODE_ENV=production
ENV PORT=10000

# Expose the port
EXPOSE 10000

# Start the application
CMD ["./docker-entrypoint.sh"]
