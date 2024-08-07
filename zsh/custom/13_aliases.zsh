# Aliases
# =======

# Some aliases may be redundant with Oh My Zsh plugins. Aliases with
# variables are single-quoted to prevent expansion at definition time.

# Proxies
alias autoproxy="ssh -v a8c-proxy"

# CLI tools
alias cat="bat"
alias cwd="pwd"
alias j="just"
alias tree="eza --tree"
alias vim='$EDITOR'
alias rr='cd $(git root)'
alias path='echo -e ${PATH//:/\\n}'

# ls aliases
alias ls="pls -g true"
alias {l,la,ll,lsa,lsal}="ls -d std"

# OS X user defaults system aliases
alias dr="defaults read"
alias dw="defaults write"

# Zsh aliases
alias zshconfig='$EDITOR $ZDOTDIR/.zshrc'
alias zshreload='source $ZDOTDIR/.zshrc'

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
