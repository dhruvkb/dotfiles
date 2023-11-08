#!/usr/bin/env osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move desk to stand position
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ⬆️
# @raycast.packageName Idåsen

tell application "Desk Controller"
  move to "102cm"
end tell

# This line will be shown in a toast message.
return "Moving desk to 102cm"
