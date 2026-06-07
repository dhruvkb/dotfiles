# Starship
# ========

# Configure Starship to store the config file in the dotfiles
# repository.
export STARSHIP_CONFIG="$HOME/dotfiles/starship/starship.toml"

# Hide warnings like timeouts from the CLI.
export STARSHIP_LOG="error"

# Load Starship prompt.
eval "$(starship init zsh)"
