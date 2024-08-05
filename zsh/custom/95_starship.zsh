# Starship
# ========

# Configure Starship to store the config file in the dotfiles
# repository.
export STARSHIP_CONFIG="$HOME/dotfiles/starship/starship.toml"

# Load Starship prompt.
eval "$(starship init zsh)"
