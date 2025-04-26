#!/bin/bash

COMPLETION_DIR="$HOME/.local/share/bash-completion"
GIT_VERSION=$(git --version | awk '{print $3}')
COMPLETION_SCRIPT_PATH="$COMPLETION_DIR/git-completion-$GIT_VERSION.bash"

# Check if the script is readable. If not, fetch it and then give instructions to source it.
if [ ! -r "$COMPLETION_SCRIPT_PATH" ]; then
  mkdir -p "$COMPLETION_DIR"
  curl "https://raw.githubusercontent.com/git/git/$GIT_VERSION/contrib/completion/git-completion.bash" -o "$COMPLETION_SCRIPT_PATH" 
fi

# Echo the instruction for the user to source the script
echo "Git completion script downloaded. To enable it, run:"
source "$COMPLETION_SCRIPT_PATH"


