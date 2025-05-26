FROM node:18-alpine

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy Prisma schema and generate client
COPY prisma ./prisma/
RUN npx prisma generate

# Copy application source
COPY . .

# Build the application
RUN npm run build

# Run Prisma migrations
RUN chmod +x /app/docker-entrypoint.sh

# Expose the port the app runs on
ENV PORT=10000
EXPOSE 10000

# Start the application
CMD ["/app/docker-entrypoint.sh"]
