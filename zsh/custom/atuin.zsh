# Atuin
# =====

# Configure Atuin to store the config file in the dotfiles repository.
export ATUIN_CONFIG_DIR="$HOME/dotfiles/atuin"

# Enable Autuin's Zsh integration.
eval "$(atuin init zsh)"
