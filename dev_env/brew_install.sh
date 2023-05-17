#!/usr/bin/env bash

# Install Brew formulae
brew install \
  colima \
  docker \
  docker-compose \
  exa \
  gh \
  just \
  jq \
  pipx \
  python@3.11 \
  starship

# Install Docker Compose CLI plugin
mkdir -p ~/.docker/cli-plugins
ln -sfn \
  $HOMEBREW_PREFIX/opt/docker-compose/bin/docker-compose \
  ~/.docker/cli-plugins/docker-compose

# Install Brew casks
brew install --cask \
  1password \
  alt-tab \
  arc \
  fig \
  iterm2 \
  jetbrains-toolbox \
  logi-options-plus \
  macvim \
  raycast \
  transmission \
  visual-studio-code \
  vlc

# Tap into the fonts cask and install JetBrains Mono
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
