# OrbStack
# ========

# Update path to include CLI tools like `docker`, `kubectl`, `orb` etc.
if [[ ":$PATH:" != *":$HOME/.orbstack/bin:"* ]]; then
	if [ -e "$HOME/.orbstack/shell/init.zsh" ]; then
		source "$HOME/.orbstack/shell/init.zsh"
	else
		echo "OrbStack init file not found."
	fi
fi
