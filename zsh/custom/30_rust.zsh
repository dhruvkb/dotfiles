# Rust configuration
# ==================

# rustup
# ======

# Configure rustup to use XDG data directory.
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# Cargo
# =====

# Configure Cargo to use XDG data directory.
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# Add Cargo binaries to the path.
if [[ ":$PATH:" != *":$CARGO_HOME/bin:"* ]]; then
	if [ -e "$CARGO_HOME/env" ]; then
		source "$CARGO_HOME/env"
	else
		echo "Cargo env file not found."
	fi
fi
