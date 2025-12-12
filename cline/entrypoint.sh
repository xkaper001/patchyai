#!/bin/sh
set -eu 

# Check if OPENROUTER_API_KEY is set
if [ -n "$OPENROUTER_API_KEY" ]; then
    echo "Configuring cline with OpenRouter..."
    cline auth --provider openRouter \
        --apikey "$OPENROUTER_API_KEY" \
        --modelid "${OPENROUTER_MODEL_ID:-openai/gpt-oss-120b}"
    echo "OpenRouter configuration complete."  
else
    echo "Warning: OPENROUTER_API_KEY not set. Skipping authentication."
fi

# Execute cline with all passed arguments
exec cline "$@"
