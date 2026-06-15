#!/usr/bin/env zsh

# This script installs, and if necessary, updates the listed packages using the
# relevant package managers.
#
# These are language specific package managers being used to install global
# binaries, so it's not ideal. If any of these packages can be moved to
# Homebrew-managed installs, they should.

source "${0:A:h}/_common.zsh"

# `qmk` is installed by a different bootstrap script.
UV_PACKAGES=(
	linak-controller
	ipython
)

print -r -- '┌─ Installing uv packages...'
for package in "${UV_PACKAGES[@]}"; do
	# Install uv packages individually.
	indent uv tool install "$package"
done
green '└─ done.\n'

# Upgrade all uv packages to their latest versions.
print -r -- '┌─ Upgrading uv packages...'
indent uv tool upgrade --all
green '└─ done.\n'

CARGO_PACKAGES=(
	cargo-release
	cargo-update
	cargo-bloat
)
CARGO_LOCKED_PACKAGES=(
	cargo-nextest
)

print -r -- '┌─ Installing cargo packages...'
for package in "${CARGO_PACKAGES[@]}"; do
	# Install Cargo packages individually.
	indent cargo install "$package"
done
for package in "${CARGO_LOCKED_PACKAGES[@]}"; do
	# Install Cargo packages that require the `--locked` flag individually.
	indent cargo install --locked "$package"
done
green '└─ done.\n'

# Update all Cargo packages to their latest versions.
print -r -- '┌─ Upgrading cargo packages...'
indent cargo install-update -a
green '└─ done.\n'
