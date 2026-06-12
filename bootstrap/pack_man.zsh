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

printf '┌─ Installing uv packages...\n'
for package in ${UV_PACKAGES[@]}; do
	# Install uv packages individually.
	indent uv tool install $package
done
green '└─ done.\n'

# Upgrade all uv packages to their latest versions.
printf '┌─ Upgrading uv packages...\n'
indent uv tool upgrade --all
green '└─ done.\n'

CARGO_PACKAGES=(
	cargo-release
	cargo-update
)

printf '┌─ Installing cargo packages...\n'
for package in ${CARGO_PACKAGES[@]}; do
	# Install Cargo packages individually.
	indent cargo install $package
done
green '└─ done.\n'

# Update all Cargo packages to their latest versions.
printf '┌─ Upgrading cargo packages...\n'
indent cargo install-update -a
green '└─ done.\n'
