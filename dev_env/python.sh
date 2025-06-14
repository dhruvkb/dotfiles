#!/usr/bin/env bash

# This script will install, and if necessary, update the listed
# packages.

# Create the directory where packages will be installed.
#
# See also `zsh/custom/30_python.zsh`.
if [ ! -d "/opt/uv" ]; then
	sudo mkdir /opt/uv
	sudo chown -R "$(whoami)":admin /opt/uv
	mkdir /opt/uv/bin
fi

# Install uv packages.
PACKAGES=(
	pdm
	linak-controller
	ipython
)

for package in ${PACKAGES[@]}; do
	uv tool install $package
done

# Upgrade all uv packages to their latest versions.
uv tool upgrade --all
