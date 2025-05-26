FROM node:18-alpine

WORKDIR /app

# Add dependencies for Prisma and other native modules
RUN apk add --no-cache python3 make g++ openssl-dev

# Copy package files and npm config
COPY package*.json .npmrc ./
RUN npm install --no-optional --legacy-peer-deps --loglevel verbose
RUN npm install -g prisma

# Copy Prisma schema and generate client
COPY prisma ./prisma/
RUN npx prisma generate

# Copy application source
COPY . .

# Build the application
RUN npm run build

# Copy and fix entrypoint script
COPY docker-entrypoint.sh .
RUN apk add --no-cache dos2unix && \
    dos2unix /app/docker-entrypoint.sh && \
    chmod +x /app/docker-entrypoint.sh

# Expose the port the app runs on
ENV PORT=10000
EXPOSE 10000

# Start the application
CMD ["/app/docker-entrypoint.sh"]
