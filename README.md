# patchyai

AI-powered patch management and automation tool.

## Docker Setup

### Building the Docker Image

To build the Cline CLI Docker image:

```bash
docker build -f cline/Dockerfile.cline -t patchyai-cline:latest .
```

### Running the Container

Run the Cline CLI with OpenRouter authentication:

```bash
docker run -it --rm \
  -e OPENROUTER_API_KEY="your-api-key-here" \
  -e OPENROUTER_MODEL_ID="openai/gpt-oss-120b" \
  -v $(pwd):/workspace \
  patchyai-cline:latest [cline-commands]
```

#### Environment Variables

- `OPENROUTER_API_KEY` (required): Your OpenRouter API key for authentication. The container will exit with an error if this is not provided.
- `OPENROUTER_MODEL_ID` (optional): Model to use (default: `openai/gpt-oss-120b`)

#### Examples

Run a scan:
```bash
docker run -it --rm \
  -e OPENROUTER_API_KEY="your-key" \
  -v $(pwd):/workspace \
  patchyai-cline:latest scan /workspace
```

Interactive mode:
```bash
docker run -it --rm \
  -e OPENROUTER_API_KEY="your-key" \
  -v $(pwd):/workspace \
  patchyai-cline:latest
```

### Docker Image Features

- **Lightweight**: Based on Node.js 22 Alpine Linux (~200MB)
- **Secure**: Runs as non-root user (clineuser)
- **Optimized**: Clean npm cache and minimal layers
- **Flexible**: Automatic OpenRouter authentication via environment variables

### Development

To test changes locally:
```bash
# Build the image
docker build -f cline/Dockerfile.cline -t patchyai-cline:dev .

# Run with your workspace mounted
docker run -it --rm \
  -e OPENROUTER_API_KEY="$OPENROUTER_API_KEY" \
  -v $(pwd):/workspace \
  patchyai-cline:dev
```
