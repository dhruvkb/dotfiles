# CAUTION: Symlinked file!
# ORIGINAL: `dotfiles/zsh/.zshenv`

# Add the given directory to $PATH, if it is not already present.
#
# Usage:
#   pathadd <directory>
# where
#   <directory> is the directory to add to $PATH
pathadd() {
	if [[ $# -eq 0 ]]; then
		echo "Usage: pathadd <directory>"
		return
	fi

	local dir=$1

	if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
		PATH="${PATH:+"$PATH:"}$dir"
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

# All other configuration goes in `ZDOTDIR`.
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Make Zsh write history to XDG-compatible path.
# This, for some reason, did not work from `dotfiles/zsh/custom/09_histories.zsh`.
export HISTFILE="$XDG_STATE_HOME/zsh/history"
