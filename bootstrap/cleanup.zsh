#!/usr/bin/env zsh

# This script cleans up junk files from the home directory.

source "${0:A:h}/_common.zsh"

print -rn -- 'Clearing up junk files...'
# Remove the junk files created before the symlink existed.
rm -rf "$HOME/.zsh_history" "$HOME/.zsh_sessions" "$HOME/.lesshst"
green 'done.\n'
