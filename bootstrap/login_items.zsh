#!/usr/bin/env zsh

# This script configures the apps that launch silently at login.

source "${0:A:h}/_common.zsh"

print -rn -- 'Configuring login items...'
login_items=(
	'/Applications/AutoProxxy.app'
	'/Applications/Beeper Desktop.app'
	'/Applications/BetterMouse.app'
	'/Applications/Cloudflare WARP.app'
	'/Applications/OrbStack.app'
	'/Applications/Raycast Beta.app'
	'/System/Applications/Reminders.app'
	'/Applications/Tunnelblick.app'
)
for app in $login_items; do
	name="${${app:t}:r}"
	osascript -e "tell application \"System Events\" to if not (exists login item \"$name\") then make login item at end with properties {path:\"$app\", hidden:true}" >/dev/null
done
green 'done.\n'
