# Proxies
alias autoproxy="ssh -N -D 8080 dhruvkb@proxy.automattic.com" # A8C

# CLI tools
alias cat="bat"
alias cwd="pwd"
alias j="just"
alias ls="exa"
alias tree="ls --tree"
alias rr='cd $(git root)'

# ZSH aliases
alias zshconfig="vim ~/.zshrc"
alias omzconfig="vim ~/.oh-my-zsh"
alias sspconfig="vim ~/.spaceshiprc"
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
alias deit="docker exec -ti"

# Docker-Compose aliases
alias dc="docker compose"
alias dcup="dc up"
alias dcdn="dc down"
alias dce="dc exec"
alias dcdu="dcdn && dcup -d"
alias dcdpu="dcdn -v && dcup -d"
alias dcdev="dc -f docker-compose.yml -f docker-compose.dev.yml"

# Terraform aliases
alias tf="terraform"
alias tfr="tf refresh"
alias tfp="tf plan"
alias tfa="tf apply"
alias tfi="tf import"
