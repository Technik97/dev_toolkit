FROM mcr.microsoft.com/dotnet/sdk:9.0 AS dotnet

# Install dependencies and basic setup for development
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set up the working directory for the backend
WORKDIR /workspace/backend

# Copy necessary files (make sure your .NET project files are in the appropriate place)
COPY ./backend /workspace/backend

# Command to start bash, or you can use `dotnet run` for the backend if preferred
CMD ["bash"]