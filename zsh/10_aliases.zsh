# Proxies
alias autoproxy="ssh -N -D 8080 dhruvkb@proxy.automattic.com" # A8C
alias yoproxy="ssh -N -D 1337 ubuntu@yoshared" # Yojak

# LS
# See `exa` @ https://the.exa.website
alias ls="exa"

# AWS
sshu() { ssh ubuntu@$1 }

# ZSH aliases
alias zshconfig="vim ~/.zshrc"
alias omzconfig="vim ~/.oh-my-zsh"
alias sspconfig="vim ~/.spaceshiprc"
alias zshreload="source ~/.zshrc"

# Pipenv aliases
alias pipi="pipenv install"
alias pipu="pipenv uninstall"
alias pips="pipenv shell"

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
