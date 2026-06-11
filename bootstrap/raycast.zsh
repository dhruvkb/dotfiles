#!/usr/bin/env zsh

# This script bootstraps Raycast.

source "${0:A:h}/_common.zsh"

printf "Populating desk UUID..."
# Populate the desk UUID
mkdir -p ~/dotfiles/raycast/data/
desk_uuid=$($UV_TOOL_BIN_DIR/linak-controller --scan \
	| grep "Desk " \
	| awk -F':' '{print $1}')
echo "DESK_UUID='$desk_uuid'" > ~/dotfiles/raycast/data/desk.sh
green "done.\n"
