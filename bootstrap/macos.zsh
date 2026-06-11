#!/usr/bin/env zsh

# This script configures macOS settings.

source "${0:A:h}/_common.zsh"

printf 'Configuring Finder...'
# Set default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"
# Show all filename extensions.
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
# Set default search scope to current folder.
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"
# Show the path bar.
defaults write com.apple.finder "ShowPathbar" -bool "true"
green 'done.\n'

printf 'Configuring Dock...'
# Hide the Dock automatically.
defaults write com.apple.dock autohide -bool true
# Do not show recent applications in the Dock.
defaults write com.apple.dock show-recents -bool false
# Scroll on an app icon to exposé it.
defaults write com.apple.dock "scroll-to-open" -bool "true"
yellow 'LATER, ADD OR REMOVE DOCK ITEMS MANUALLY.\n'
green 'done.\n'

printf 'Configuring TextEdit...'
# We want TextEdit to prefer plain text.
defaults write com.apple.TextEdit RichText -int 0
green 'done.\n'

printf 'Configuring window management...'
# Remove margins from tiled windows.
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false
# Do not hide windows when clicking the desktop.
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
green 'done.\n'

printf 'Configuring keyboard...'
# Correct spelling automatically
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Capitalise words automatically
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# Show inline predictive text
defaults write NSGlobalDomain NSAutomaticInlinePredictionEnabled -bool 	false
# Add full stop with double-space ("period substitution")
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
# Disable smart quotes.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# Disable smart dashes.
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
green 'done.\n'

printf 'Configuring trackpad...'
# Enable for the built-in trackpad.
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# Enable for magic trackpad.
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# Enable for the login screen.
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Enable for the user.
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
green 'done.\n'

yellow 'LOG OUT AND LOG BACK IN!\n'
