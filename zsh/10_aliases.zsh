# Aliases
# =======

# Aliases with vars are single-quoted to prevent expansion at definition time.

# Proxies
alias autoproxy="ssh -N -D 8080 dhruvkb@proxy.automattic.com" # A8C

# CLI tools
alias cat="bat"
alias cwd="pwd"
alias j="just"
alias pls="$HOME/Developer/personal/mega/pls/target/release/pls"
alias ls="pls --grid=true"
alias lsal="pls --det=std"
alias tree="eza --tree"
alias rr='cd $(git root)'

# ZSH aliases
alias zshconfig='${EDITOR} ~/.zshrc'
alias omzconfig='${EDITOR} ~/.oh-my-zsh'
alias sspconfig='${EDITOR} ~/.spaceshiprc'
alias zshreload="source ~/.zshrc"

# Brew aliases
alias badd="brew install"
alias bdoc="brew doctor"
alias barm="brew autoremove"
alias bcln="brew cleanup"
alias bwhy="brew uses --installed"
alias bdep="brew deps --installed --tree"
alias blvs="brew leaves --installed-on-request"

# Docker aliases
alias dock="docker"
alias dimg="docker image"
alias dcon="docker container"
alias dvol="docker volume"
alias dxit="docker exec -ti"

# Docker-Compose aliases
alias dc="docker compose"
alias dcup="dc up"
alias dcdn="dc down"
alias dcex="dc exec"
alias dcdu="dcdn && dcup -d"  # du as in "down up"
alias dcnu="dcdn -v && dcup -d"  # nu as in "new"

# Finds which software or application is using the given port number.
#
# Usage:
#   whoisusing <port>
# where
#   <port> is the port number
whoisusing() {
  lsof -i ":$1"
}

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
  local dirmap_file="$HOME/dotfiles/zsh/.bookmarks"

  if [[ ! -f $dirmap_file ]]; then
    echo "The dirmap file does not exist."
    return
  fi

  local dir=$(grep "^$name=" "$dirmap_file" | cut -d'=' -f2-)
  if [[ -n $dir ]]; then
    cd $dir
  else
    echo "No directory mapping found for $name."
  fi
}
