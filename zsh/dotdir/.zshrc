# This runs automatically once `~/.zshenv` points `ZDOTDIR` to this directory.

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

# Load all `.zsh` files from the custom directory.
# This lets us break down the config into multiple files, each concerned with a
# specific topic.
for config_file in ~/dotfiles/zsh/custom/*.zsh(N-.); do
	source "$config_file"
done
