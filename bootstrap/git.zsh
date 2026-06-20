#!/usr/bin/env zsh

# This script pulls the themes file from delta's GitHub repository.

source "${0:A:h}/_common.zsh"

print -rn -- 'Downloading Catppuccin delta themes...'
curl -fsSL \
	-o "$HOME/dotfiles/git/data/themes.gitconfig" \
	https://raw.githubusercontent.com/catppuccin/delta/main/catppuccin.gitconfig
green 'done.\n'
