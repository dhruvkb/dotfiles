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
XDG_STATE_HOME="$HOME/.local/state"

# Ensure that the log directory exists.
mkdir -p "$XDG_STATE_HOME/raycast"

# Write timestamp to log file.
echo "$(date) sit.sh" >> "$XDG_STATE_HOME/raycast/sit.log"

# Get the UUID of the desk.
# This may change when changing devices.
# /opt/uv/bin/linak-controller --scan | grep "Desk 5097" | awk -F':' '{print $1}'
DESK_UUID="2463056C-4B86-D6F6-E42D-2CA4A18A21C4"

# Run the linak-controller command in background with output redirected to log file.
/opt/uv/bin/linak-controller \
  --mac-address "$DESK_UUID" \
  --move-to 620 \
  >>"$XDG_STATE_HOME/raycast/sit.log" \
  2>&1 \
  &

# This line will be shown in a toast message.
echo "Moving desk to 62cm"
