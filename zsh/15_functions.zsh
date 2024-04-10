# Reads the file `.bookmarks` and provides a short way to refer to the
# bookmarked directory. An optional command can be specified to run instead
# of `cd` (e.g. to open the directory in an IDE or in Finder).
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
