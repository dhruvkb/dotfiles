# This file is the real `.zshenv` that configures Zsh.
#
# - If `ZDOTDIR` is set, this real `.zshenv` gets sourced, instead of the stub.
# - If `ZDOTDIR` is not set, the stub gets sourced and it sets `ZDOTDIR`. But,
#   since one `.zshenv` has been sourced, the real one will not be. So the stub
#   sources it explicitly.

# Add the given directory to $PATH, if it is not already present.
#
# Usage:
#   pathadd [-p] <dir>
# where
#   -p    prepend to $PATH instead of appending
#   <dir> is the dir to add to $PATH
pathadd() {
	local prepend=0
	if [[ $1 == "-p" ]]; then
		prepend=1
		shift
	fi

	if [[ $# -eq 0 ]]; then
		print -r -- "Usage: pathadd [-p] <dir>"
		return
	fi

	local dir=$1

	if [[ -d "$dir" ]] && [[ ":$PATH:" != *":$dir:"* ]]; then
		# We do not want `PATH` to be local, changing the global `PATH` is the goal.
		# Hence the `noka` comments.
		if [[ $prepend -eq 1 ]]; then
			PATH="$dir${PATH:+":$PATH"}" # noka: ZC1043
		else
			PATH="${PATH:+"$PATH:"}$dir" # noka: ZC1043
		fi
	fi
}

# XDG specification variables are used everywhere so they need to be set first.
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# There isn't an official XDG spec for binaries, but this is conventional.
export XDG_BIN_HOME="$HOME/.local/bin"
pathadd "$XDG_BIN_HOME"

# Some macOS apps use a different directory convention.
export MACOS_CONFIG_HOME="$HOME/Library/Application Support"

# Disable Terminal.app's Resume feature. Otherwise its /etc/zshrc_Apple_Terminal
# installs a precmd hook that overrides HISTFILE per session and dumps state
# into $ZDOTDIR/.zsh_sessions, defeating the XDG paths set in histories.zsh.
export SHELL_SESSIONS_DISABLE=1
