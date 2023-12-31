# CAUTION: Symlinked file

# Add the given directory to $PATH, if it is not already present.
#
# Usage:
#   pathadd <directory>
# where
#   <directory> is the directory to add to $PATH
pathadd() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: pathadd <directory>"
    return
  fi

  local dir=$1

  if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
    PATH="${PATH:+"$PATH:"}$dir"
  fi
}

# iTerm2
# ======

# Load iTerm2 shell integration. To download the shell integration script, run
# `just iterm`.
if [ -e "$HOME/dotfiles/iTerm/shell_integration.zsh" ]; then
  source "$HOME/dotfiles/iTerm/shell_integration.zsh"
else
  echo "iTerm2 shell integration not found."
fi
