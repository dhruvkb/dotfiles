# Add the given directory to $PATH, if it is not already present.
#
# Usage:
#   pathadd <directory>
# where
#   <directory> is the directory to add to $PATH
pathadd() {
	if [[ $# -eq 0 ]]; then
		echo "Usage: pathadd <directory>"
		return
	fi

	local dir=$1

	if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
		PATH="${PATH:+"$PATH:"}$dir"
	fi
}
