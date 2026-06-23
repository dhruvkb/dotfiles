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
alias gcm="git commit --message"
alias gcf="git commit --fixup"
alias gca="git commit --amend"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log --graph --decorate"
alias glo="git log --oneline --graph --decorate"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gps='git push --set-upstream origin $(git curr)'
alias gpl="git pull"
alias gplr="git pull --rebase"
alias gs="git stash"
alias gsp="git stash pop"
alias gst="git status"

# GitHub CLI
# ==========

# Configure GitHub CLI to store its configs file in the dotfiles repository.
export GH_CONFIG_DIR="$HOME/dotfiles/gh"
