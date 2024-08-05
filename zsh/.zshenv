# XDG specification variables are used everywhere so they need to be set first.
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Some macOS apps use a different directory convention.
export MACOS_CONFIG_HOME="$HOME/Library/Application Support"

# All other configuration goes in `ZDOTDIR`.
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
