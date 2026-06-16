# Git
# ===

# Configure Git to store the global config file in the dotfiles repository.
export GIT_CONFIG_GLOBAL="$HOME/dotfiles/git/config"

# Expose custom `git-<name>` subcommands.
pathadd "$HOME/dotfiles/git/bin"

# Get the name of the current Git branch.
#
# Usage
#   git_current_branch
git_current_branch() {
	local ref
	ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2>/dev/null)
	local ret=$?
	if [[ $ret != 0 ]]; then
		[[ $ret == 128 ]] && return # no git repo.
		ref=$(__git_prompt_git rev-parse --short HEAD 2>/dev/null) || return
	fi
	echo ${ref#refs/heads/}
}

# Aliases
alias g="git"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit --message"
alias gcf="git commit --fixup"
alias gca="git commit --amend"
alias gl="git log --graph --decorate"
alias glo="git log --oneline --graph --decorate"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gps='git push --set-upstream origin $(git_current_branch)'
alias gpl="git pull"
alias gplr="git pull --rebase"

# GitHub CLI
# ==========

# Configure GitHub CLI to store its configs file in the dotfiles repository.
export GH_CONFIG_DIR="$HOME/dotfiles/gh"
