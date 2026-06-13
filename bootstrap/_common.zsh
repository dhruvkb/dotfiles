# Shared helpers for the bootstrap scripts. Source this with:
#   source "${0:A:h}/_common.zsh"

# Print the message in green foreground color.
green() {
	printf '\033[32m%b\033[0m' "$1"
}

# Print the message in yellow foreground color.
yellow() {
	printf '\033[33m%b\033[0m' "$1"
}

# Run a command, indenting its output with a vertical bar.
indent() {
	"$@" 2>&1 | sed 's/^/│ /'
}

# Convert a string to a slug, suitable for filenames.
slugify() {
	local intermediate
	# Lowercase and replace non-alphanumeric with hyphens
	intermediate="${(L)1}"
	intermediate="${intermediate//[^a-z0-9]/-}"
	# Squeeze duplicate hyphens and trim edges
	echo "$intermediate" | tr -s '-' | sed 's/^-//;s/-$//'
}
