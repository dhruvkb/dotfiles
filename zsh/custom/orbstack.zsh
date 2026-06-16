# OrbStack configuration
# ======================

# Docker
# ======

# Configure Docker to use XDG config directory.
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# Use Bake to orchestrate build execution in the most efficient way.
# https://docs.docker.com/compose/how-tos/dependent-images/#build-with-bake
export COMPOSE_BAKE="true"

# Update path to include CLI tools like `docker`, `kubectl`, `orb` etc.
if [[ ":$PATH:" != *":$HOME/.orbstack/bin:"* ]]; then
	if [[ -e "$HOME/.orbstack/shell/init.zsh" ]]; then
		source "$HOME/.orbstack/shell/init.zsh"
	else
		print -r -- "OrbStack init file not found."
	fi
fi

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
alias dcdu="dcdn && dcup -d"    # du as in "down up"
alias dcnu="dcdn -v && dcup -d" # nu as in "new"
