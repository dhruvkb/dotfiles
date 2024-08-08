# This file contains configuration from `.zshrc` that appears after
# Oh My Zsh has been initialised.

# If this is turned off, `locale` reverts everything to "C".
export LANG="en_US.UTF-8"

# Set preferred editor for local and remote sessions.
if command -v hx &>/dev/null; then
  export EDITOR="hx"
elif command -v vim &>/dev/null; then
  export EDITOR="vim"
else
  export EDITOR="vi"
fi
