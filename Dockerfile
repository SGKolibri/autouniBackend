# Use a specific Node.js version with hash for reproducible builds
FROM node:18.19-alpine3.18

# Set working directory
WORKDIR /app

# Install system dependencies
# Use a single RUN command to reduce layers and ensure all dependencies are installed
RUN apk update && \
    apk add --no-cache \
    python3 \
    make \
    g++ \
    openssl-dev \
    bash \
    dos2unix

# Copy package files
COPY package.json package-lock.json* ./

# Install dependencies with explicit NPM path
# Use a specific version of npm for consistency
RUN /usr/local/bin/npm install --production=false

# Install prisma globally
RUN /usr/local/bin/npm install -g prisma

# Generate Prisma client
COPY prisma ./prisma/
RUN /usr/local/bin/npx prisma generate

# Copy source code
COPY tsconfig.json ./
COPY src ./src/

# Build the application
RUN /usr/local/bin/npm run build

# Copy entrypoint script and make it executable
COPY docker-entrypoint.sh ./
RUN dos2unix /app/docker-entrypoint.sh && \
    chmod +x /app/docker-entrypoint.sh

# Set environment variables
ENV NODE_ENV=production
ENV PORT=10000

# Expose the port
EXPOSE 10000

# Start the application
CMD ["/app/docker-entrypoint.sh"]
