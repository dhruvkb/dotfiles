#!/usr/bin/env zsh

# This script configures macOS settings.

source "${0:A:h}/_common.zsh"

print -rn -- 'Configuring Finder...'
# Set default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string PfHm
# Show all filename extensions.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Set default search scope to current folder.
defaults write com.apple.finder FXDefaultSearchScope -string SCcf
# Show the path bar.
defaults write com.apple.finder ShowPathbar -bool true
# Sort folders before files.
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# Don't litter network volumes with .DS_Store files.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Don't litter USB volumes with .DS_Store files.
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
green 'done.\n'

print -rn -- 'Configuring Dock...'
# Hide the Dock automatically.
defaults write com.apple.dock autohide -bool true
# Do not show recent applications in the Dock.
defaults write com.apple.dock show-recents -bool false
# Scroll on an app icon to exposé it.
defaults write com.apple.dock scroll-to-open -bool true
# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true
green 'done.\n'

print -rn -- 'Configuring TextEdit...'
# We want TextEdit to prefer plain text.
defaults write com.apple.TextEdit RichText -int 0
green 'done.\n'

print -rn -- 'Configuring window management...'
# Remove margins from tiled windows.
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false
# Do not hide windows when clicking the desktop.
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false
green 'done.\n'

print -rn -- 'Configuring keyboard...'
# Correct spelling automatically
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Capitalise words automatically
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# Show inline predictive text
defaults write NSGlobalDomain NSAutomaticInlinePredictionEnabled -bool false
# Add full stop with double-space ("period substitution")
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
# Disable smart quotes.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# Disable smart dashes.
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
green 'done.\n'

print -rn -- 'Configuring screenshots...'
# Save screenshots to ~/Screenshots instead of the Desktop.
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
# Use PNG format for screenshots.
defaults write com.apple.screencapture type -string png
green 'done.\n'

print -rn -- 'Configuring screensaver...'
# Start the screensaver after 10 minutes of inactivity.
defaults -currentHost write com.apple.screensaver idleTime -int 600
# Require the password after sleep or screensaver begins.
defaults write com.apple.screensaver askForPassword -int 1
# Set the delay to 5 seconds so that the password is not required immediately.
defaults write com.apple.screensaver askForPasswordDelay -int 5
green 'done.\n'

print -rn -- 'Configuring trackpad...'
# Enable for the built-in trackpad.
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# Enable for magic trackpad.
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# Enable for the login screen.
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Enable for the user.
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
green 'done.\n'

# `pmset` requires superuser, but the rest of the file must be run as the
# current user, so `sudo` is intentional.

print -r -- '┌─ Configuring display sleep...'
# Turn the display off after 5 minutes of inactivity on battery.
sudo pmset -b displaysleep 5 # noka: ZC1047
# Turn the display off after 15 minutes of inactivity on power adapter.
sudo pmset -c displaysleep 15 # noka: ZC1047
green '└─ done.\n'

yellow 'LOG OUT AND LOG BACK IN!\n'
yellow 'ADD OR REMOVE DOCK ITEMS MANUALLY.\n'
