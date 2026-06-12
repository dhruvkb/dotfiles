#!/usr/bin/env zsh

# This script links configuration files to the right place.
# - SSH: `~/.ssh/config`
# - uv, Helix, Ghostty: subdirectories under `XDG_CONFIG_HOME`
# - VS Code: subdirectories under `MACOS_CONFIG_HOME`
# - Hammerspoon: `defaults`

source "${0:A:h}/_common.zsh"

printf 'Linking SSH config...'
# Ensure the .ssh directory exists.
mkdir -p "$HOME/.ssh"
# Remove existing config file, if it exists.
rm -f "$HOME/.ssh/config"
# Create a symlink to the SSH config file in this repo.
ln -s "$HOME/dotfiles/ssh/config" "$HOME/.ssh/config"
green 'done.\n'

printf 'Linking uv config...'
# Ensure the directory exists.
mkdir -p "$XDG_CONFIG_HOME/uv"
# Remove existing config file, if it exists.
rm -f "$XDG_CONFIG_HOME/uv/uv.toml"
# Create a symlink to the uv config file in this repo.
ln -s "$HOME/dotfiles/uv/uv.toml" "$XDG_CONFIG_HOME/uv/uv.toml"
green 'done.\n'

printf 'Linking Helix config...'
# Ensure the directory exists.
mkdir -p "$XDG_CONFIG_HOME/helix"
# Remove existing config files, if they exist.
rm -f "$XDG_CONFIG_HOME/helix/config.toml" "$XDG_CONFIG_HOME/helix/languages.toml"
# Create symlinks to the Helix config files in this repo.
ln -s "$HOME/dotfiles/helix/config.toml" "$XDG_CONFIG_HOME/helix/config.toml"
ln -s "$HOME/dotfiles/helix/languages.toml" "$XDG_CONFIG_HOME/helix/languages.toml"
green 'done.\n'

printf 'Linking Ghostty config...'
# Ensure the directory exists.
mkdir -p "$XDG_CONFIG_HOME/ghostty"
# Remove existing config file, if it exists.
rm -f "$XDG_CONFIG_HOME/ghostty/config.ghostty"
# Create a symlink to the Ghostty config file in this repo.
ln -s "$HOME/dotfiles/ghostty/config.ghostty" "$XDG_CONFIG_HOME/ghostty/config.ghostty"
green 'done.\n'

printf 'Linking VS Code config...'
# Ensure the directory exists.
mkdir -p "$MACOS_CONFIG_HOME/Code/User"
# Remove existing config files, if they exist.
rm -f "$MACOS_CONFIG_HOME/Code/User/settings.json" "$MACOS_CONFIG_HOME/Code/User/keybindings.json"
# Create symlinks to the VS Code config files in this repo.
ln -s "$HOME/dotfiles/Code/User/settings.json" "$MACOS_CONFIG_HOME/Code/User/settings.json"
ln -s "$HOME/dotfiles/Code/User/keybindings.json" "$MACOS_CONFIG_HOME/Code/User/keybindings.json"
green 'done.\n'

printf 'Linking Hammerspoon config...'
defaults write org.hammerspoon.Hammerspoon MJConfigFile "$HOME/dotfiles/hammerspoon/init.lua"
green 'done.\n'
