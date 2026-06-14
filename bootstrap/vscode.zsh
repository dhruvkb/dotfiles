#!/usr/bin/env zsh

# This script sets up Visual Studio Code.

source "${0:A:h}/_common.zsh"

print -r -- '┌─ Installing extensions...'
EXTENSIONS=(
	# Themes
	Catppuccin.catppuccin-vsc       # aka Catppuccin for VSCode
	Catppuccin.catppuccin-vsc-icons # aka Catppuccin Icons for VSCode
	# Editor
	EditorConfig.EditorConfig             # aka EditorConfig
	streetsidesoftware.code-spell-checker # aka Code Spell Checker
	# Languages
	ms-python.python         # aka Python
	rust-lang.rust-analyzer  # aka rust-analyzer
	tamasfe.even-better-toml # aka Even Better TOML
	unifiedjs.vscode-mdx     # aka MDX
	# Frameworks
	astro-build.astro-vscode # aka Astro
	Vue.volar                # aka Vue (Official)
	# Linters & formatters
	charliermarsh.ruff     # aka Ruff
	dbaeumer.vscode-eslint # aka ESLint
	esbenp.prettier-vscode # aka Prettier - Code formatter
	oxc.oxc-vscode         # aka Oxc
	# Tools
	ms-azuretools.vscode-containers # aka Container Tools
)
# Note:
# - Python also bundles Pylance, Python Debugger and Python Environments.
# - Ruff depends on Python and will be disabled if Python is disabled.
# - Claude Code will install Claude Code for VS Code automatically.
for extension in "${EXTENSIONS[@]}"; do
	indent code --install-extension "$extension" --force
done
green '└─ done.\n'

yellow 'DISABLE ALL NON-UNIVERSAL EXTENSIONS!\n'
