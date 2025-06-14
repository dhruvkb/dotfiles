#!/usr/bin/env bash

# This script will perform the following steps:
#
# - Install Homebrew if it is not already installed.
# - Install, and if necessary, update the listed formulae.
# - Install, and if necessary, update the listed casks.

# Update Homebrew if it is already installed, install if it isn't.
if $(command -v brew &>/dev/null); then
	echo "Homebrew is already installed."
	brew update
else
	echo "Installing Homebrew..."
	# This does not follow `curl | bash` because it needs `sudo` access.
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Brew formulae
FORMULAE=(
	atuin
	awscli
	bat
	coreutils
	cormacrelf/tap/dark-notify
	eza
	gh
	git-crypt
	git-delta
	gnupg
	hashicorp/tap/terraform
	helix
	jq
	just
	pls-rs/pls/pls
	starship
	uv
	xh
	yt-dlp
	zx
)

brew install ${FORMULAE[@]}

# Install Brew casks
CASKS=(
	1password
	1password-cli
	arc
	automattic-texts
	bluetility
	cloudflare-warp
	coteditor
	cursor
	firefox
	font-monaspace
	font-symbols-only-nerd-font
	github
	keyboardcleantool
	latest
	logi-options+
	msty
	netnewswire
	obsidian
	openmtp
	orbstack
	orion
	raycast
	slack
	transmission
	tunnelblick
	visual-studio-code
	vlc
	whatsapp
	yaak
	zed
	zoom
)

brew install --cask ${CASKS[@]}
