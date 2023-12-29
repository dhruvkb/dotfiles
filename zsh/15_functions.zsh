# Reads the file `.bookmarks` and provides a short way to jump to the bookmarked
# directory.
#
# Usage:
#   goto <name>
# where
#   <name> is the name of the bookmark
function goto() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: goto <name>"
    return
  fi

  local name=$1

  local bookmarks_file="$HOME/dotfiles/zsh/.bookmarks"
  if [[ ! -f $bookmarks_file ]]; then
    echo "The dirmap file does not exist."
    return
  fi

  local dir=$(grep "^$name=" "$bookmarks_file" | cut -d'=' -f2-)
  if [[ -n $dir ]]; then
    cd $dir
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
