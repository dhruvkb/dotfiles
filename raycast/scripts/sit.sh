#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move desk to sit position
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ⬇️
# @raycast.packageName Idåsen

# Environment variables are not populated in Raycast scripts.
XDG_DATA_HOME="$HOME/.local/share"
UV_TOOL_BIN_DIR="$XDG_DATA_HOME/uv/tools_bin/"
XDG_STATE_HOME="$HOME/.local/state"

# Source the machine-local desk UUID.
UUID_FILE="$HOME/dotfiles/raycast/data/desk.sh"
if [[ ! -f "$UUID_FILE" ]]; then
	echo "Define desk UUID in desk.sh"
	exit 1
fi
source "$UUID_FILE"

# Ensure that the log directory exists.
mkdir -p "$XDG_STATE_HOME/raycast"

# Write timestamp to log file.
echo "$(date) sit.sh" >>"$XDG_STATE_HOME/raycast/sit.log"

# Run the linak-controller command in background with output redirected to log file.
"$UV_TOOL_BIN_DIR/linak-controller" \
	--mac-address "$DESK_UUID" \
	--move-to 620 \
	>>"$XDG_STATE_HOME/raycast/sit.log" \
	2>&1 \
	&

# This line will be shown in a toast message.
echo "Moving desk to 62cm"
