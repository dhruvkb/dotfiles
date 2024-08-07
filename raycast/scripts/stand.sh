#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move desk to stand position
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ⬆️
# @raycast.packageName Idåsen

XDG_STATE_HOME="$HOME/.local/state"
mkdir -p $XDG_STATE_HOME/raycast
/opt/pipx/bin/linak-controller \
  --mac-address 84F900A3-AB7F-C330-501D-575AB6D66797 \
  --move-to 1020 \
	&>"$XDG_STATE_HOME/raycast/stand.log" \
  &

# This line will be shown in a toast message.
echo "Moving desk to 102cm"
