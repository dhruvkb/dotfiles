#!/usr/bin/env osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open IPython
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 🐍
# @raycast.packageName iTerm2

tell application "iTerm2"
  create window with default profile
  tell current session of current window
    write text "ipython"
  end tell
end tell

# This line will be shown in a toast message.
return "Opened IPython"
