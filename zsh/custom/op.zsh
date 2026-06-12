# 1Password configuration
# =======================

# Source 1Password CLI's `plugin.sh` if it exists.
if [[ -f "$XDG_CONFIG_HOME/op/plugin.sh" ]]; then
	source "$XDG_CONFIG_HOME/op/plugin.sh"

	# Mark the state to know that the sourcing was successful.
	export OP_PLUGIN_SOURCED=1
fi
