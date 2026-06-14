#!/usr/bin/env zsh

# This script installs and configures QMK.

source "${0:A:h}/_common.zsh"

# Since we cannot rely on `qmk` to be on the path, we directly check if the
# binary exists at `$UV_TOOL_BIN_DIR/qmk`.
if [[ -x $UV_TOOL_BIN_DIR/qmk ]]; then
	green "QMK is already installed.\n"
else
	yellow "QMK is not installed.\n"

	print -r -- '┌─ Installing QMK...'
	# This follows `curl ... | sh`.
	# `SKIP_UV=1` reuses the Homebrew-installed `uv` instead of letting
	# Astral's installer drop a second copy in `~/.local/bin`.
	curl -fsSL https://install.qmk.fm | SKIP_UV=1 sh
	green '└─ done.\n'
fi

# Set up QMK using personal fork, unless it is already set up. We consider it
# set up when the home directory exists and `qmk_home` points to it in config.
if [[ -d "/Users/dhruvkb/Developer/dhruvkb/qmk_firmware" ]] &&
	$UV_TOOL_BIN_DIR/qmk config user.qmk_home | grep -q "=/Users/dhruvkb/Developer/dhruvkb/qmk_firmware "; then
	green "QMK is already set up.\n"
else
	# Ensure the parent directory exists before running `qmk setup`.
	mkdir -p "/Users/dhruvkb/Developer/dhruvkb"

	print -r -- '┌─ Setting up QMK...'
	# This will also set the `qmk_home` config flag to the right directory.
	indent $UV_TOOL_BIN_DIR/qmk setup dhruvkb/qmk_firmware \
		--home "/Users/dhruvkb/Developer/dhruvkb/qmk_firmware" \
		--branch supreme_keymap \
		--yes
	green '└─ done.\n'
fi

print -r -- '┌─ Configuring keyboard and keymap...'
# Set the keyboard and keymap to use.
indent $UV_TOOL_BIN_DIR/qmk config \
	user.keyboard=zsa/moonlander/reva \
	user.keymap=supreme
green '└─ done.\n'
