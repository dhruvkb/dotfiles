#!/usr/bin/env bash

# This script will perform the following steps:
#
# - Install Homebrew if it is not already installed.
# - Install, and if necessary, update the listed formulae.
# - Install, and if necessary, update the listed casks.

# Update Homebrew if it is already installed, install if it isn't.
# Since we cannot rely on `brew` to be on the path, we check if the
# Homebrew executable at `/opt/homebrew/bin/brew` exists.
if [ -f /opt/homebrew/bin/brew ]; then
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

/opt/homebrew/bin/brew install ${FORMULAE[@]}

# Install Brew casks
CASKS=(
	1password
	1password-cli
	arc
	automattic-texts
	beeper
	bluetility
	cloudflare-warp # needs password entry
	coteditor
	cursor
	firefox
	font-monaspace
	font-symbols-only-nerd-font
	ghostty
	github
	hammerspoon
	keyboardcleantool
	latest
	logi-options+ # needs restart
	msty
	netnewswire
	obsidian # needs additional steps at launch
	openmtp
	orbstack
	orion
	raycast
	slack
	transmission
	tunnelblick # needs to be moved to `/Applications`
	visual-studio-code
	vlc
	whatsapp
	yaak
	zed
	zoom # needs password entry
)

/opt/homebrew/bin/brew install --cask ${CASKS[@]}
