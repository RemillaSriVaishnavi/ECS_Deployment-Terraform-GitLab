# ===========================
# Stage 1 - Build Application
# ===========================
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY app/package*.json ./

# Install production dependencies
RUN npm install --omit=dev

# Copy application source code
COPY app/ .

# ===========================
# Stage 2 - Production Image
# ===========================
FROM node:18-alpine

WORKDIR /app

# Copy built application
COPY --from=builder /app .

# Default ECS port
ENV PORT=80

# Expose application port
EXPOSE 80

# Start application
CMD ["node", "index.js"]