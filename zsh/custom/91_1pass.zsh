# 1Password configuration
# =======================

# Include 1Password plugins configuration.
if [ -e "$XDG_CONFIG_HOME/op/plugins.sh" ]; then
	source "$XDG_CONFIG_HOME/op/plugins.sh"
else
	echo "1Password shell plugins file not found."
fi
