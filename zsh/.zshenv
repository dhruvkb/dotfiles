# CAUTION: Symlinked file!
# ORIGINAL: `dotfiles/zsh/.zshenv`
#
# This file is a bootstrapping stub for Zsh.
#
# - If `ZDOTDIR` is set, the real `.zshenv` gets sourced, instead of this stub.
# - If `ZDOTDIR` is not set, the stub gets sourced and it sets `ZDOTDIR`. But,
#   since one `.zshenv` has been sourced, the real one will not be. So the stub
#   sources it explicitly.

export ZDOTDIR="$HOME/dotfiles/zsh/dotdir"

source "$ZDOTDIR/.zshenv"
