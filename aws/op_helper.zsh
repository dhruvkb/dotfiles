#!/usr/bin/env zsh

# Use this script as the credential_process in your AWS CLI config to fetch
# credentials from 1Password and use AWS CLI normally from tools like Terraform.
#
# This script can only print the credentials to STDOUT, so it logs intermediate
# steps to STDERR. This is required to use it with the AWS CLI.

set -euo pipefail

vault=${1:-}
secret_name=${2:-}

if [[ -z $vault || -z $secret_name ]]; then
	print -r -- "Usage: ${0:t} <vault> <secret_name>" >&2
	exit 1
fi

# `--format json` + `jq` is preferable to parsing a human-readable table.
# `--arg name "$secret_name"` passes the value as data instead of interpolating.
# `first(...)` picks the first of potentially multiple results.
secret_id=$(op item list --vault "$vault" --format json |
	jq -r --arg name "$secret_name" 'first(.[] | select(.title | contains($name)) | .id) // empty')
print -r -- "Secret ID: $secret_id" >&2

cat <<EOF | op inject
{
	"Version": 1,
	"AccessKeyId": "{{ op://${vault}/${secret_id}/access key id }}",
	"SecretAccessKey": "{{ op://${vault}/${secret_id}/secret access key }}"
}
EOF
