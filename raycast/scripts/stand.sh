#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move desk to stand position
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ⬆️
# @raycast.packageName Idåsen

# Environment variables are not populated in Raycast scripts.
XDG_STATE_HOME="$HOME/.local/state"

# Ensure that the log directory exists.
mkdir -p "$XDG_STATE_HOME/raycast"

# Write timestamp to log file.
echo "$(date) stand.sh" >> "$XDG_STATE_HOME/raycast/stand.log"

# Run the linak-controller command in background with output redirected to log file.
/opt/uv/bin/linak-controller \
  --mac-address 84F900A3-AB7F-C330-501D-575AB6D66797 \
  --move-to 1020 \
  >>"$XDG_STATE_HOME/raycast/stand.log" \
  2>&1 \
  &

# This line will be shown in a toast message.
echo "Moving desk to 102cm"
