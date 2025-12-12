#!/bin/sh
set -eu 

# Check if OPENROUTER_API_KEY is set
if [ -z "${OPENROUTER_API_KEY:-}" ]; then
    echo "Error: OPENROUTER_API_KEY environment variable is required but not set." >&2
    echo "Please provide your OpenRouter API key:" >&2
    echo "  docker run -e OPENROUTER_API_KEY=\"your-key\" ..." >&2
    exit 1
fi

echo "Configuring cline with OpenRouter..."
cline auth --provider openRouter \
    --apikey "$OPENROUTER_API_KEY" \
    --modelid "${OPENROUTER_MODEL_ID:-openai/gpt-oss-120b}"
echo "OpenRouter configuration complete."

# Execute cline with all passed arguments
exec cline "$@"
