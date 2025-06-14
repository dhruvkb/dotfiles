#!/usr/bin/env bash

# This script will install Rust (via rustup) if it is not already
# installed. It will also install Cargo packages that work as custom
# commands.

# Install Rust and Cargo.
#
# The path should not be modified because the call to source
# `$CARGO_HOME/env` is already codified into the ZSH configuration.
if $(command -v rustc &>/dev/null); then
	echo "Rust is already installed."
else
	echo "Installing Rust..."
	curl -fsSL https://sh.rustup.rs | bash -s -- --no-modify-path
fi

# Install Cargo custom commands.
PACKAGES=(
	cargo-release
)

cargo install ${PACKAGES[@]}
