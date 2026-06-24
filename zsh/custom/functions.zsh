# Functions
# =========
#
# This script contains a collection of functions that perform common
# tasks, which cannot be accomplished using aliases.

# Reload the shell session.
#
# This is useful for applying changes to the shell configuration without having
# to close and reopen the terminal (or open a fresh one).
#
# Usage:
#   reload
reload() {
	exec zsh
}

# Go to the directories from the XDG Base Directory specification.
#
# Usage
#   xdg <name>
# where
#   <name> is the name of the XDG directory
xdg() {
	if [[ $# -eq 0 ]]; then
		echo "Usage: xdg <name>" >&2
		return 1
	fi

	local name=$1

	case $name in
	data) cd $XDG_DATA_HOME ;;
	config) cd $XDG_CONFIG_HOME ;;
	state) cd $XDG_STATE_HOME ;;
	cache) cd $XDG_CACHE_HOME ;;
	*)
		echo "Unknown XDG directory: $name" >&2
		return 1
		;;
	esac
}

# Reads the file `.bookmarks` and provides a short way to `cd` to a
# bookmarked directory.
#
# Usage:
#   goto        - print help
#   goto --edit - open bookmarks file in $EDITOR
#   goto <name> - cd to the bookmarked directory
# where
#   <name> is the name of a bookmark from the bookmarks file
goto() {
	local bookmarks_file="$XDG_DATA_HOME/dotfiles/zsh/bookmarks"

	if [[ $# -eq 0 ]]; then
		echo "Usage: goto <name>" >&2
		echo "       goto --edit" >&2
		return 1
	fi

	if [[ $1 == "--edit" ]]; then
		$EDITOR "$bookmarks_file"
		return
	fi

	if [[ ! -f $bookmarks_file ]]; then
		echo "root=/" >"$bookmarks_file"
		echo "Created new bookmarks file at $bookmarks_file."
	fi

	local name=$1
	local dir=$(grep "^$name=" "$bookmarks_file" | cut -d'=' -f2-)
	if [[ -n $dir ]]; then
		cd "$dir" || return
	else
		echo "No bookmark found for $name." >&2
		return 1
	fi
}

# Finds which software or application is using the given port number.
#
# Usage:
#   whoisusing <port>
# where
#   <port> is the port number
whoisusing() {
	if [[ $# -eq 0 ]]; then
		echo "Usage: whoisusing <port>" >&2
		return 1
	fi

	local port=$1

	local pid=$(lsof -i ":$port" | awk 'NR==2 {print $2}')
	if [[ -n $pid ]]; then
		ps -p $pid -o command=
	else
		echo "No process is using port $port." >&2
		return 1
	fi
}

# Open the given directory, or the current directory, in Finder.
#
# Usage:
#   o [<dir> = .]
# where
#   <dir> is the directory to open (default: .)
o() {
	if [[ $# -eq 0 ]]; then
		open .
	else
		open "$@"
	fi
}

# Open the directory in Visual Studio Code.
#
# When given a directory containing one or more `.code-workspace` files,
# those workspaces are opened instead of the bare folder.
#
# Usage:
#   vsc <directory>
# where
#   <directory> is the path to open
vsc() {
	if [[ $# -eq 0 ]]; then
		echo "Usage: vsc <directory>" >&2
		return 1
	fi

	local target=$1

	if [[ -d $target ]]; then
		# Open every `.code-workspace` file in the directory, if any. Each is
		# opened with a separate invocation so it lands in its own window.
		local workspaces=("$target"/*.code-workspace(N))
		if (($#workspaces)); then
			local workspace
			for workspace in $workspaces; do
				code "$workspace"
			done
		else
			code "$target"
		fi
	else
		echo "Error: '$target' is not a directory." >&2
		return 1
	fi
}

# Serve the given directory, or the current directory, using Python HTTP
# server.
#
# Usage:
#   http [<port> = 8000] [<dir> = .]
# where
#   <port> is the port number on which to serve the files (default: 8000)
#   <dir> is the directory to serve (default: .)
http() {
	local port=${1:-8000}
	python3 -m http.server $port
}

# Create the given directory path, including parents, and immediately
# change to that directory.
#
# Usage:
#   mkcd <dir>
# where
#   <dir> is the directory path to create and change to
mkcd() {
	if [[ $# -eq 0 ]]; then
		echo "Usage: mkcd <dir>" >&2
		return 1
	fi

	mkdir -p "$@" && cd "$_" || return
}

# Get the user's name and email from their latest Git commit, formatted
# as `Full Name <email@domain.tld>`.
#
# Usage
#   ghauth <username> - get the name and email of the GitHub user
# where
#   <username> is the GitHub handle of the author
ghauth() {
	if [[ $# -eq 0 ]]; then
		echo "Usage: ghauth <username>" >&2
		return 1
	fi

	local username=$1

	env GH_PAGER="" \
		op plugin run -- \
		gh api \
		"users/$username" \
		--silent \
		2>/dev/null
	local script_exit_code=$?
	if [[ $script_exit_code -ne 0 ]]; then
		echo "Error: GitHub user '$username' not found" >&2
		return 1
	fi

	env GH_PAGER="" \
		op plugin run -- \
		gh search commits \
		--author "$username" \
		--sort author-date \
		--limit 1 \
		--json commit \
		--jq '.[0].commit.author | "\(.name) <\(.email)>"'
}

# Print a new UUID4 string. This should print both the hyphenated and
# non-hyphenated versions of the UUID, for use in different contexts.
#
# Usage
#   uuid4 - print two forms of a new UUID4 string
uuid4() {
	python3 -c 'import uuid; u = uuid.uuid4(); print(u); print(u.hex)'
}

# Update all software and packages installed on the system.
#
# This includes:
# - Homebrew formulae and casks
# - uv tools
# - Rust toolchain
# - Cargo packages
#
# This does not update Python, Node.js or Rust.
updates() {
	brew update && brew upgrade && brew cleanup && brew autoremove
	uv tool upgrade --all
	rustup update
	cargo install-update -a

	# Homebrew re-quarantines casks on upgrade, so on the first restart after an
	# update operation, all login items would simultaneously trigger Gatekeeper
	# prompts. Stripping the quarantine attribute avoids the wall of popups.
	source "$HOME/dotfiles/zsh/data/login_items.sh"
	local app
	for app in $login_items; do
		[[ -e $app ]] && xattr -dr com.apple.quarantine "$app" 2>/dev/null
	done
}
