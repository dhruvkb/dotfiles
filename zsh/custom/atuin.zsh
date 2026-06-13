# Atuin
# =====

# Configure Atuin to store the config file in the dotfiles repository.
export ATUIN_CONFIG_DIR="$HOME/dotfiles/atuin"

# Enable Atuin's Zsh integration.
if has atuin; then
	eval "$(atuin init zsh)"
else
	print -r -- "Atuin not found."
fi
