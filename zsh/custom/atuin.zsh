# Atuin
# =====

# Configure Atuin to store the config file in the dotfiles repository.
export ATUIN_CONFIG_DIR="$HOME/dotfiles/atuin"

# Enable Atuin's Zsh integration, which use the canonical pattern with `eval`.
if has atuin; then
	eval "$(atuin init zsh)" # noka: ZC1046
else
	print -r -- "Atuin not found."
fi
