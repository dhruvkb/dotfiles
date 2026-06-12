#!/usr/bin/env zsh

# This script configures the apps that launch silently at login.

source "${0:A:h}/_common.zsh"

printf 'Configuring login items...'
login_items=(
  '/Applications/Cloudflare WARP.app'
  '/Applications/BetterMouse.app'
  '/Applications/Raycast Beta.app'
  '/Applications/AutoProxxy.app'
  '/Applications/Beeper Desktop.app'
)
for app in $login_items; do
  name="${${app:t}:r}"
  osascript -e "tell application \"System Events\" to if not (exists login item \"$name\") then make login item at end with properties {path:\"$app\", hidden:true}" >/dev/null
done
green 'done.\n'
