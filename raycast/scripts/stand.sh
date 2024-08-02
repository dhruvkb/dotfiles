#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move desk to stand position
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ⬆️
# @raycast.packageName Idåsen

/opt/pipx/bin/linak-controller \
  --mac-address 84F900A3-AB7F-C330-501D-575AB6D66797 \
  --move-to 1020 \
  &

# This line will be shown in a toast message.
echo "Moving desk to 102cm"
