# ZLE
# ===

# Strip the odd numbered trailing single quote from the buffer, which is very
# likely to be a typo.
strip-trailing-squote-accept() {
	if [[ $BUFFER == *\' ]]; then
		local quotes=${BUFFER//[^\']/}
		((${#quotes} % 2 == 1)) && BUFFER=${BUFFER%\'}
	fi
	zle accept-line
}
zle -N strip-trailing-squote-accept
bindkey '^M' strip-trailing-squote-accept
