#!/usr/bin/env zsh

# This script configures Zsh.

source "${0:A:h}/_common.zsh"

# Silence the last login message.
print -rn -- 'Silencing the last login message...'
>"$HOME/.hushlogin"
green 'done.\n'

print -rn -- 'Setting up Zsh configuration...'
# Remove any existing `.zshenv` file, if it exists.
rm -f "$HOME/.zshenv"
# Create a `.zshenv` symlink that points to the one in this repo.
ln -s "$HOME/dotfiles/zsh/.zshenv" "$HOME/.zshenv"
green 'done.\n'
