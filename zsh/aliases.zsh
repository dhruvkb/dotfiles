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
