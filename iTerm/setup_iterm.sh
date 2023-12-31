#!/usr/bin/env sh

curl -s \
  -L "https://iterm2.com/shell_integration/zsh" \
  -o iTerm/shell_integration.zsh; # Full path specified because `just` runs from root directory.
echo "Downloaded shell integration script."
