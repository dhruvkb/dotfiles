#!/usr/bin/env bash

# This script switches app themes between dark and light modes. The
# following apps will be updated:
# - Helix
# - VS Code

if [ $1 == "dark" ]; then
	echo "Updating to dark theme."

	HELIX_THEME="catppuccin_mocha"
	VSCODE_THEME="catppuccin-mocha"
else
	echo "Updating to light theme."

	HELIX_THEME="catppuccin_latte"
	VSCODE_THEME="catppuccin-latte"
fi

# Helix
# =====

echo "Helix theme: $HELIX_THEME"
sed -i '' -e "s|^theme =.*$|theme = \"$HELIX_THEME\"|" $HOME/dotfiles/helix/config.toml
pkill -USR1 hx || true

# VS Code
# =======

echo "VS Code theme: $VSCODE_THEME"
sed -i '' -e "s|\"workbench.iconTheme\": \".*\"|\"workbench.iconTheme\": \"$VSCODE_THEME\"|" $HOME/dotfiles/Code/User/settings.json
