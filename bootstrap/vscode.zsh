#!/usr/bin/env zsh

# This script sets up Visual Studio Code.

source "${0:A:h}/_common.zsh"

EXTENSIONS=(
	# Themes
	Catppuccin.catppuccin-vsc
	Catppuccin.catppuccin-vsc-icons
	# Editor
	EditorConfig.EditorConfig
	# Languages
	tamasfe.even-better-toml
	ms-python.python
	rust-lang.rust-analyzer
	unifiedjs.vscode-mdx
	# Frameworks
	Vue.volar
	astro-build.astro-vscode
	# Linters & formatters
	dbaeumer.vscode-eslint
	esbenp.prettier-vscode
	oxc.oxc-vscode
	# Tools
	ms-azuretools.vscode-containers
)

print -r -- '┌─ Installing extensions...'
for extension in ${EXTENSIONS[@]}; do
	indent code --install-extension $extension --force
done
green '└─ done.\n'

yellow 'DISABLE ALL NON-UNIVERSAL EXTENSIONS!\n'
