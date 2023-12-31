# CAUTION: Symlinked file

# iTerm2
# ======

# Load iTerm2 shell integration. To download the shell integration script, run
# `just iterm`.
if [ -e "$HOME/dotfiles/iTerm/shell_integration.zsh" ]; then
  source "$HOME/dotfiles/iTerm/shell_integration.zsh"
else
  echo "iTerm2 shell integration not found."
fi
