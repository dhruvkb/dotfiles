# Automattic proxy
alias autoproxy="ssh -N -D 8080 dhruvkb@proxy.automattic.com"

# Yojak proxy
alias yoproxy="ssh -N -D 1337 ubuntu@yoshared"

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
alias dcup="docker compose up"
alias dcdn="docker compose down"
alias dce="docker compose exec"
alias dcdu="dcdn && dcup -d"
alias dcdpu="dcdn && dvol prune -f && dcup -d"
alias dcdev="dc -f docker-compose.yml -f docker-compose.dev.yml"
