# Compinit
# ========

# Pick up completion functions shipped by Homebrew formulae. `fpath` must be set
# before `compinit` is loaded.
if has brew; then
	fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

autoload -Uz compinit

_zcompdump="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# Ensure that the directory part of `_zcompdump` exists.
mkdir -p "${_zcompdump:h}"

if [[ -n "$_zcompdump"(#qN.mh+24) ]]; then
	# The file is stale, so we need to do a full security check and rebuild the cache.
	compinit -d "$_zcompdump"
else
	# The file is fresh, so we can trust it and skip the slow security check.
	compinit -C -d "$_zcompdump"
fi

# Use Shift ⇧ + Tab ⇥ to go backwards in completion lists
zmodload -i zsh/complist # Only needed for `bindkey`.
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Show completion as a menu with selectable options.
zstyle ':completion:*:*:*:*:*' menu select

# This is case-insensitive and hyphen/underscore-insensitive completion.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'

unset _zcompdump
