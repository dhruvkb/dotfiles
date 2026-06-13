#!/usr/bin/env zsh

# This script sets up SSH with 1Password and also initialises plugins.

source "${0:A:h}/_common.zsh"

print -r -- '┌─ Extracting SSH keys...'
mkdir -p "$HOME/dotfiles/ssh/data/keys"
vaults=$(op vault list --format json | jq -r '.[].id')
vaults_with_keys=()
for vault in ${(f)vaults}; do
	ssh_keys=$(op item list --categories 'SSH Key' --vault "$vault" --format json | jq -r '.[].id')
	[[ -n "$ssh_keys" ]] || continue
	vaults_with_keys+=("$vault")
	for ssh_key in ${(f)ssh_keys}; do
		ssh_key_data=$(op item get "$ssh_key" --vault "$vault" --format json)
		# Name the file after a slug of "<vault> <title>".
		vault_name=$(print -rn -- "$ssh_key_data" | jq -r '.vault.name')
		title=$(print -rn -- "$ssh_key_data" | jq -r '.title')
		indent print -rn -- "Extracting $vault_name/$title..."

		slug=$(slugify "$(print -rn -- "$ssh_key_data" | jq -r '"\(.vault.name) \(.title)"')")
		dest="$HOME/dotfiles/ssh/data/keys/$slug.pub"
		pub=$(print -rn -- "$ssh_key_data" | jq -r '.fields[] | select(.id == "public_key") | .value')
		print -r -- "$pub" >"$dest"
		# SSH keys need to have restricted permissions.
		chmod 644 "$dest"

		green "done.\n"
	done
done
green '└─ done.\n'

print -rn -- 'Configuring 1Password SSH agent...'
mkdir -p "$HOME/.config/1Password/ssh"
# Enable each vault that has SSH keys, one `[[ssh-keys]]` block each.
for vault in $vaults_with_keys; do
	printf '[[ssh-keys]]\nvault = "%s"\n\n' "$(op vault get "$vault" --format json | jq -r '.name')"
done >"$HOME/.config/1Password/ssh/agent.toml"
green 'done.\n'

PLUGINS=(
	gh
)

print -r -- '┌─ Configuring 1Password CLI plugins...'
for plugin in "${PLUGINS[@]}"; do
	# `op plugin init` is interactive so we cannot indent it.
	op plugin init "$plugin"
done
green '└─ done.\n'
