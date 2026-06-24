#!/usr/bin/env zsh

# This script pulls the themes file from delta's GitHub repository.

source "${0:A:h}/_common.zsh"

print -rn -- 'Downloading Catppuccin delta themes...'
output_file="$XDG_DATA_HOME/dotfiles/git/themes.gitconfig"
mkdir -p "${output_file:h}"
curl -fsSL \
	-o "$output_file" \
	https://raw.githubusercontent.com/catppuccin/delta/main/catppuccin.gitconfig
green 'done.\n'
