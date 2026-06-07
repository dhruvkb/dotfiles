# This runs automatically once `~/.zshenv` points `ZDOTDIR` to this directory.

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

pathadd "$XDG_BIN_HOME"

# Load all `.zsh` files from the custom directory.
# This lets us break down the config into multiple files, each concerned with a
# specific topic.
for config_file in ~/dotfiles/zsh/custom/*.zsh(N-.); do
  source "$config_file"
done
