#!/usr/bin/env osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move desk to sit position
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ⬇️
# @raycast.packageName Idåsen

tell application "Desk Controller"
  move to "62cm"
end tell

# This line will be shown in a toast message.
return "Moving desk to 62cm"
