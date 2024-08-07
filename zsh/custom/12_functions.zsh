# Functions
# =========
#
# This script contains a collection of functions that perform common
# tasks, which cannot be accomplished using aliases.

# Go to the directories from the XDG Base Directory specification.
#
# Usage
#   xdg <name>
# where
#   <name> is the name of the XDG directory
function xdg() {
	if [[ $# -eq 0 ]]; then
		echo "Usage: xdg <name>"
		return
	fi

	local name=$1

	case $name in
		data) cd $XDG_DATA_HOME ;;
		config) cd $XDG_CONFIG_HOME ;;
		state) cd $XDG_STATE_HOME ;;
		cache) cd $XDG_CACHE_HOME ;;
		*) echo "Unknown XDG directory: $name" ;;
	esac
}

# Reads the file `.bookmarks` and provides a short way to refer to the
# bookmarked directory. An optional command can be specified to run
# instead of `cd` (e.g. to open the directory in an IDE or in Finder).
#
# Usage:
#   goto <name> [<cmd> = cd]
# where
#   <name> is the name of the bookmark
#   <cmd> is the name of the command to run (default: cd)
function goto() {
	if [[ $# -eq 0 ]]; then
		echo "Usage: goto <name> [<cmd> = cd]"
		return
	fi

	local name=$1
	local cmd=${2:-cd}

	local bookmarks_file="$HOME/dotfiles/zsh/.bookmarks"
	if [[ ! -f $bookmarks_file ]]; then
		echo "The dirmap file does not exist."
		return
	fi

	local dir=$(grep "^$name=" "$bookmarks_file" | cut -d'=' -f2-)
	if [[ -n $dir ]]; then
		echo "$cmd \"$dir\"" # Print the command to be executed.
		$cmd "$dir"
	else
		echo "No directory mapping found for $name."
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
		echo "Usage: whoisusing <port>"
		return
	fi

	local port=$1

	local pid=$(lsof -i ":$port" | awk 'NR==2 {print $2}')
	if [[ -n $pid ]]; then
		ps -p $pid -o command=
	else
		echo "No process is using port $port."
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

# Run a Raycast script by its name.
#
# Usage:
#   ray <name>
# where
#   <name> is the name of the Raycast script
ray() {
	~/dotfiles/raycast/scripts/$1.sh &>/dev/null
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
		echo "Usage: mkcd <dir>"
		return
	fi

	mkdir -p $@ && cd $_
}
