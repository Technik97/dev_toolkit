FROM node:22-bookworm-slim

# Set up the working directory
WORKDIR /workspace/frontend

# Install necessary development tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install global NPM packages
RUN npm install -g typescript pnpm nuxi

# Create a non-root user
RUN useradd -m devuser
USER devuser

# Copy project files
COPY ./frontend /workspace/frontend

# Default command
CMD ["bash"]
