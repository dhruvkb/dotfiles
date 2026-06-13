# This runs automatically once `~/.zshenv` points `ZDOTDIR` to this directory.

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

# Check if the given command exists on the system.
#
# Usage:
#   has <cmd>
# where
#   <cmd> is the command to check for
has() {
	if [[ $# -eq 0 ]]; then
		print -r -- "Usage: has <cmd>"
		return
	fi

	local cmd=$1

	command -v "$cmd" &>/dev/null
}

pathadd "$XDG_BIN_HOME"

# Load all `.zsh` files from the custom directory.
# This lets us break down the config into multiple files, each concerned with a
# specific topic.
for config_file in ~/dotfiles/zsh/custom/*.zsh(N-.); do
	source "$config_file"
done
