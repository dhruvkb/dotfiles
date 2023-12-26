#!/usr/bin/env bash

# Install Brew formulae
brew install \
  awscli \
  bat \
  coreutils \
  eza \
  gh \
  git-crypt \
  just \
  jq \
  mkcert \
  neovim \
  pipx \
  postgresql@13 \
  python@3.11 \
  starship \
  terraform \
  xh

# Install Docker Compose CLI plugin
mkdir -p ~/.docker/cli-plugins
ln -sfn \
  $HOMEBREW_PREFIX/opt/docker-compose/bin/docker-compose \
  ~/.docker/cli-plugins/docker-compose

# Install Brew casks
brew install --cask \
  1password \
  1password-cli \
  arc \
  cloudflare-warp \
  coteditor \
  fig \
  firefox \
  iterm2 \
  jetbrains-toolbox \
  latest \
  logi-options-plus \
  obsidian \
  orbstack \
  raycast \
  signal \
  slack \
  transmission \
  visual-studio-code \
  vlc \
  whatsapp

# Tap into the fonts cask and install JetBrains Mono
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

# Tap into the `pls` tap and install `pls`
brew tap pls-rs/pls
brew install pls-rs/pls/pls
