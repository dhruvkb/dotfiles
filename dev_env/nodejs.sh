#!/usr/bin/env zsh

# This script will install nvm if it is not already installed. Then it
# will install the LTS version of Node.js and enable Corepack.

# Source the `.zshrc` file to load Oh My Zsh, which will load the `nvm`
# plugin, which will make the following script work normally.
source $ZDOTDIR/.zshrc

if $(command -v nvm &>/dev/null); then
	echo "nvm is already installed."
else
	echo "Installing nvm..."
	# We use the `/dev/null` profile because Oh My Zsh's `nvm` plugin
	# handles this automatically.
	TAG=$(curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
	curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/$TAG/install.sh | env PROFILE=/dev/null bash
fi

# Install the current LTS version of Node.js.
nvm install --lts
nvm use --lts

# Enable Corepack so that `pnpm` is automatically provisioned.
corepack enable
