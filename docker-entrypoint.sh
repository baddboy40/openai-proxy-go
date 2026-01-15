#!/bin/sh

# Entrypoint script for Docker container
# Loads environment variables from .env and runs proxy binary

echo "Starting OpenAI Proxy..."

# Check if .env file exists inside container (optional)
if [ -f /app/.env ]; then
    echo "Loading environment variables from .env file..."
    # Load variables from .env, skipping comments and empty lines
    set -a
    . /app/.env
    set +a
else
    echo "Using environment variables from docker-compose.yml"
fi

# Check required variables
if [ -z "$OPENAI_MASTER_API_KEY" ]; then
    echo "Error: OPENAI_MASTER_API_KEY is required"
    echo "Please set it in .env file or as environment variable"
    exit 1
fi

if [ -z "$OUR_API_KEYS" ]; then
    echo "Error: OUR_API_KEYS is required"
    echo "Please set it in .env file or as environment variable"
    exit 1
fi

# Check if binary exists
if [ ! -f "/app/proxy" ]; then
    echo "Error: /app/proxy not found"
    exit 1
fi

# Check if binary is executable
if [ ! -x "/app/proxy" ]; then
    echo "Error: /app/proxy is not executable"
    exit 1
fi

# Check binary format (basic check) - only if file command is available
if command -v file >/dev/null 2>&1; then
    BINARY_TYPE=$(file /app/proxy)
    if echo "$BINARY_TYPE" | grep -q "ELF"; then
        echo "Binary format: Linux ELF (OK)"
    else
        echo "WARNING: Binary format check: $BINARY_TYPE"
        echo "Expected Linux ELF binary"
    fi
fi

# Run the binary using exec to replace shell process
echo "Executing proxy binary..."
exec /app/proxy
