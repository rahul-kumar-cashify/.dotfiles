#!/bin/bash

COMPLETION_DIR="$HOME/.local/share/bash-completion/completion"
GIT_VERSION=$(git --version | awk '{print $3}')
COMPLETION_SCRIPT_PATH="$COMPLETION_DIR/git-completion-$GIT_VERSION.bash"
URL="https://raw.githubusercontent.com/git/git/v$GIT_VERSION/contrib/completion/git-completion.bash"

# Check if the downloaded file contains "404: Not Found"
if grep -q "404: Not Found" "$COMPLETION_SCRIPT_PATH"; then
  rm -f "$COMPLETION_SCRIPT_PATH"  # Remove invalid file
  exit 1
fi

# Check if the script is readable. If not, fetch it.
if [ ! -r "$COMPLETION_SCRIPT_PATH" ]; then
  mkdir -p "$COMPLETION_DIR"
  curl -fsSL "$URL" -o "$COMPLETION_SCRIPT_PATH"
fi


# Source the script
source "$COMPLETION_SCRIPT_PATH"

