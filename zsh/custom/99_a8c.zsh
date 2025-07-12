# Automattic-specific shell config.

# Connect to the Automattic proxy server and configure network settings
# to use that as a SOCKS proxy for Wi-Fi networks.
#
# Usage:
#   proxy_a8c
function proxy_a8c() {
	setopt localtraps # Prevent traps from applying the the entire session.

	local port=8080

	function revert_settings() {
		echo "Tunnel closed!"

		echo "Reverting proxy settings."
		networksetup -setsocksfirewallproxystate Wi-Fi off
		echo "Proxy settings reverted!"
	}
	trap revert_settings EXIT INT TERM HUP

	echo "Configuring proxy settings."
	networksetup -setsocksfirewallproxy Wi-Fi 127.0.0.1 $port
	networksetup -setsocksfirewallproxystate Wi-Fi on
	echo "Proxy settings configured!"

	echo "Opening tunnel. Logs:"
	ssh -D $port a8c-proxy # See SSH config for exact params.
}
