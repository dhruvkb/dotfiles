#!/usr/bin/env zsh

# This script bootstraps Raycast.

source "${0:A:h}/_common.zsh"

print -rn -- "Populating desk UUID..."
# Populate the desk UUID
uuid_file="$XDG_DATA_HOME/dotfiles/raycast/desk.sh"
mkdir -p "${uuid_file:h}"
desk_uuid=$($UV_TOOL_BIN_DIR/linak-controller --scan | awk -F':' '/Desk / {print $1}')
print -r -- "desk_uuid='$desk_uuid'" >$uuid_file
green 'done.\n'

# Clone `beam`, my monorepo of personal Raycast extensions, unless it is already
# cloned.
beam_dir="$HOME/Developer/dhruvkb/beam"
if [[ -d $beam_dir ]]; then
	print -rn -- 'Cloning beam...'
	green 'skipped!\n'
else
	# Ensure the parent directory exists before cloning.
	mkdir -p "$HOME/Developer/dhruvkb"

	print -r -- '┌─ Cloning beam...'
	# Clone over HTTPS since this runs before the 1Password SSH agent is set up.
	indent git clone https://github.com/dhruvkb/beam.git "$beam_dir"
	green '└─ done.\n'
fi

print -r -- '┌─ Installing beam dependencies...'
indent pnpm --dir "$beam_dir" install
green '└─ done.\n'

print -r -- '┌─ Loading beam extensions into Raycast...'
# `ray develop` registers an extension with Raycast and builds it, then watches
# for changes indefinitely. We only need the one-time registration and build,
# which persist once Raycast knows about the extension, so start each watcher,
# let it settle, and stop it. Raycast itself must already be running.
for ext_dir in "$beam_dir"/extensions/*(/N); do
	print -r -- "│ ${ext_dir:t}"
	(cd "$ext_dir" && pnpm exec ray develop -I) >/dev/null 2>&1 &
	ray_pid=$!
	# Give the watcher time to register the extension and finish the initial
	# build before stopping it.
	sleep 20
	kill "$ray_pid" 2>/dev/null
	wait "$ray_pid" 2>/dev/null
done
green '└─ done.\n'
