#!/bin/bash

COMPLETION_DIR="$HOME/.local/share/bash-completion"
DOCKER_COMPLETION_PATH="$COMPLETION_DIR/docker"

# Create the directory if it doesn't exist
mkdir -p "$COMPLETION_DIR"

# Check if the Docker completion script already exists
if [ ! -r "$DOCKER_COMPLETION_PATH" ]; then
  docker completion bash > "$DOCKER_COMPLETION_PATH"
fi

# Source the Docker completion script
source "$DOCKER_COMPLETION_PATH"

