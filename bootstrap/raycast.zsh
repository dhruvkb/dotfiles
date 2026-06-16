#!/usr/bin/env zsh

# This script bootstraps Raycast.

source "${0:A:h}/_common.zsh"

print -rn -- "Populating desk UUID..."
# Populate the desk UUID
mkdir -p ~/dotfiles/raycast/data/
desk_uuid=$($UV_TOOL_BIN_DIR/linak-controller --scan | awk -F':' '/Desk / {print $1}')
print -r -- "DESK_UUID='$desk_uuid'" >~/dotfiles/raycast/data/desk.sh
green 'done.\n'
