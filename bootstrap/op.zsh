#!/usr/bin/env zsh

# This script sets up SSH and GPG with 1Password and also initialises plugins.

source "${0:A:h}/_common.zsh"

vaults=$(op vault list --format json | jq -r '.[].id')

print -r -- '┌─ Extracting SSH keys...'
mkdir -p "$HOME/dotfiles/ssh/data/keys"
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
		chmod u=rw,go= "$dest"

		green 'done.\n'
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

print -r -- '┌─ Loading GPG keys...'
for vault in ${(f)vaults}; do
	gpg_keys=$(op item list --categories 'Document' --vault "$vault" --format json | jq -r '.[] | select(.title | test("^GPG/")) | .id')
	[[ -n "$gpg_keys" ]] || continue
	for gpg_key in ${(f)gpg_keys}; do
		gpg_key_data=$(op item get "$gpg_key" --vault "$vault" --format json)
		vault_name=$(print -rn -- "$gpg_key_data" | jq -r '.vault.name')
		title=$(print -rn -- "$gpg_key_data" | jq -r '.title')
		indent print -rn -- "Loading $vault_name/$title..."

		gpg_key_content=$(op read "op://$vault_name/$gpg_key/private key/private.pgp")
		gpg_passphrase=$(op read "op://$vault_name/$gpg_key/password")

		# Read the fingerprint from the key file without touching the keyring.
		fpr=$(
			gpg \
				--with-colons \
				--show-keys =(print -r -- "$gpg_key_content") \
				2>/dev/null |
				awk -F: '/^fpr:/ {print $10; exit}'
		)

		# Import via loopback pinentry, with the passphrase passed through a
		# temporary file to keep it out of argv. `gpg --import` is a merge, so this
		# operation is idempotent.
		gpg \
			--batch \
			--pinentry-mode loopback \
			--passphrase-file =(print -r -- "$gpg_passphrase") \
			--import =(print -r -- "$gpg_key_content") \
			&>/dev/null

		# Mark the key as ultimately trusted (trust value 6).
		print -r -- "$fpr:6:" | gpg --import-ownertrust &>/dev/null

		green 'done.\n'
	done
done
green '└─ done.\n'

print -r -- '┌─ Configuring 1Password CLI plugins...'
PLUGINS=(
	gh
)
for plugin in "${PLUGINS[@]}"; do
	# `op plugin init` is interactive so we cannot indent it.
	op plugin init "$plugin"
done
green '└─ done.\n'
