#!/usr/bin/env zsh

# This script installs or, if already present, updates Homebrew.
# Then it installs, and if necessary, updates the listed formulae and casks.

source "${0:A:h}/_common.zsh"

# Since we cannot rely on `brew` to be on the path, we directly check if the
# binary exists at `/opt/homebrew/bin/brew`.
if [[ -x /opt/homebrew/bin/brew ]]; then
	green "Homebrew is already installed.\n"

	print -r -- '┌─ Updating Homebrew...'
	indent /opt/homebrew/bin/brew update
	green '└─ done.\n'
else
	print -r -- '┌─ Installing Homebrew...'
	# This does not follow `curl | bash` because it needs `sudo` access.
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	green '└─ done.\n'
fi

print -r -- '┌─ Installing Homebrew formulae...'
# Install Brew formulae
FORMULAE=(
	anomalyco/tap/opencode
	atuin
	awscli
	bat
	coreutils
	eza
	ffmpeg
	fnm
	gh
	git-crypt
	git-delta
	gnupg
	hashicorp/tap/terraform
	helix
	jq
	just
	pls-rs/pls/pls
	rustup
	starship
	uv
	xh
	yt-dlp
	zx
)
indent /opt/homebrew/bin/brew install ${FORMULAE[@]}
green '└─ done.\n'

print -r -- '┌─ Installing Homebrew casks...'
# Install Brew casks
CASKS=(
	1password
	1password-cli
	arc
	beeper
	bettermouse
	claude-code
	cloudflare-warp
	coteditor
	font-inter
	font-monaspace
	font-symbols-only-nerd-font
	ghostty
	hammerspoon
	keyboardcleantool
	latest
	obsidian
	openmtp
	orbstack
	orion
	slack
	transmission
	tunnelblick
	visual-studio-code
	vlc
	whatsapp
	yaak
	zed
)
indent /opt/homebrew/bin/brew install --cask ${CASKS[@]}
green '└─ done.\n'
