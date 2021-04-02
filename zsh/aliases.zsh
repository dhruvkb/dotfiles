# Automattic proxy
alias autoproxy="ssh -N -D 8080 dhruvkb@proxy.automattic.com"
alias checksock="http --proxy=https:socks5://127.0.0.1:8080 https://en.wordpress.com/whatismyip\?basic"
alias checkipv4="http https://api.ipify.org"

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
alias dc="docker-compose"
alias dce="docker-compose exec"
alias dcdu="docker-compose down && docker-compose up -d"