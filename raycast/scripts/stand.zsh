#!/usr/bin/env zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move desk to stand position
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ⬆️
# @raycast.packageName Idåsen

set -euo pipefail

# Environment variables are not populated in Raycast scripts.
XDG_DATA_HOME="$HOME/.local/share"
UV_TOOL_BIN_DIR="$XDG_DATA_HOME/uv/tools_bin/"
XDG_STATE_HOME="$HOME/.local/state"

# Source the machine-local desk UUID.
UUID_FILE="$HOME/dotfiles/raycast/data/desk.sh"
if [[ ! -f "$UUID_FILE" ]]; then
	print -r -- "Define desk UUID in desk.sh"
	exit 1
fi
source "$UUID_FILE"

# Ensure that the log directory exists.
mkdir -p "$XDG_STATE_HOME/raycast"

# Write timestamp to log file.
print -r -- "$(date) stand.zsh" >>"$XDG_STATE_HOME/raycast/stand.log"

# Run the linak-controller command in background with output redirected to log file.
"$UV_TOOL_BIN_DIR/linak-controller" \
	--mac-address "$DESK_UUID" \
	--move-to 1020 \
	>>"$XDG_STATE_HOME/raycast/stand.log" \
	2>&1 \
	&

# This line will be shown in a toast message.
print -r -- "Moving desk to 102cm"
