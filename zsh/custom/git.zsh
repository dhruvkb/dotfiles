# Git
# ===

# Configure Git to store the global config file in the dotfiles repository.
export GIT_CONFIG_GLOBAL="$HOME/dotfiles/git/config"

# Expose custom `git-<name>` subcommands.
pathadd "$HOME/dotfiles/git/bin"

# Aliases
alias g="git"
alias ga="git add"
alias gc="git commit"
alias gcmsg="git commit -m"
alias glo="git log --oneline --graph --decorate"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gpsup='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gpl="git pull"

# GitHub CLI
# ==========

# Configure GitHub CLI to store its configs file in the dotfiles repository.
export GH_CONFIG_DIR="$HOME/dotfiles/gh"
