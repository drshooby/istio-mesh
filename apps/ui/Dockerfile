# Dockerfile adapted from https://github.com/alireza-farokhi/nextsjs-bun-docker

# -------- Build Stage --------
FROM oven/bun:1.2.21-alpine AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package.json bun.lock ./
RUN bun install

# Copy all source code
COPY . .

# Disable Next.js telemetry
ENV NEXT_TELEMETRY_DISABLED=1

# Build the Next.js app
RUN bun next build

# -------- Production Stage --------
FROM oven/bun:1.2-alpine AS production

WORKDIR /app

# Copy only the built output and package files
COPY --from=builder /app/package.json ./
COPY --from=builder /app/bun.lock ./
COPY --from=builder /app/.next ./.next
# COPY --from=builder /app/public ./public

# Install only production dependencies (optional)
RUN bun install --production

# Expose port
EXPOSE 3000

# Start the Next.js app
CMD ["bun", "next", "start"]
