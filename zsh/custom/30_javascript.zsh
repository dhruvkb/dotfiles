# JavaScript configuration
# ========================

# npm
# ===

# Configure npm to store the config file in the dotfiles repository.
export NPM_CONFIG_USERCONFIG="$HOME/dotfiles/npm/npmrc"

# pnpm
# ====

# Configure pnpm to use the XDG data directory.
export PNPM_HOME="/Users/dhruvkb/.local/share/pnpm"

# Add pnpm binaries to the path.
pathadd $PNPM_HOME
