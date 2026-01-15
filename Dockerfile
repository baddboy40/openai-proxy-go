# Dockerfile for OpenAI Proxy
# Использует Linux бинарник proxy-linux

FROM alpine:latest

# Install ca-certificates, wget for healthcheck, and file utility for binary check
RUN apk --no-cache add ca-certificates wget file

WORKDIR /app

# Copy entrypoint script and Linux binary
COPY docker-entrypoint.sh /app/docker-entrypoint.sh
COPY proxy-linux /app/proxy

# Make scripts and binary executable
RUN chmod +x /app/docker-entrypoint.sh /app/proxy

# Expose port (default 3000, can be overridden via PROXY_PORT env var)
EXPOSE 3000

# Health check (uses default port 3000, adjust if PROXY_PORT is different)
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:3000/healthz || exit 1

# Use entrypoint script to load env vars and run proxy
ENTRYPOINT ["/app/docker-entrypoint.sh"]
