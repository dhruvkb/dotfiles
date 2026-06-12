# Rust configuration
# ==================

# rustup
# ======

# Configure rustup to use XDG data directory.
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# Add rustup proxies to the path.
pathadd "$(brew --prefix rustup)/bin"

# Cargo
# =====

# Configure Cargo to use XDG data directory.
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# Note: even if its not on the path, Cargo will look inside `$CARGO_HOME/bin`
# for subcommands i.e. bins starting with "cargo-". If there are binaries except
# these subcommands, uncomment the line below.
# pathadd "$CARGO_HOME/bin"
