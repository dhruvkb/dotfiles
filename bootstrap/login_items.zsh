#!/usr/bin/env zsh

# This script configures the apps that launch silently at login.

source "${0:A:h}/_common.zsh"

print -rn -- 'Configuring login items...'
source "$HOME/dotfiles/zsh/data/login_items.sh"
for app in $login_items; do
	name="${${app:t}:r}"
	osascript -e "tell application \"System Events\" to if not (exists login item \"$name\") then make login item at end with properties {path:\"$app\", hidden:true}" >/dev/null
	# Stripping fails for root-owned apps; ignore and keep looping.
	[[ -e $app ]] && xattr -dr com.apple.quarantine "$app" 2>/dev/null || true
done
green 'done.\n'
