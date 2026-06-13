#!/usr/bin/env zsh

# Use this script as the credential_process in your AWS CLI config to fetch
# credentials from 1Password, authenticate with MFA, and use AWS CLI normally
# from tools like Terraform.
#
# This script can only print the credentials to STDOUT, so it logs intermediate
# steps to STDERR. This is required to use it with the AWS CLI.

set -euo pipefail

vault=${1:-}
secret_name=${2:-}
profile=${3:-default}

if [[ -z $vault || -z $secret_name ]]; then
	echo "Usage: ${0:t} <vault> <secret_name> [profile]" >&2
	exit 1
fi

hash=$(printf '%s' "${vault}${secret_name}" | shasum -a 256 | cut -c1-8)
cache_file="${0:A:h}/data/${hash}.json"

# Compare the expiration timestamp inside `jq` with normalization.
# - macOS `date` cannot parse ISO 8601 with a `Z` suffix without a brittle format string.
# - `jq`'s `fromdateiso8601` handles ISO 8601, but *only* with the `Z` suffix.
#
# `2>/dev/null` swallows the error from a malformed/empty cache file.
if [[ -f $cache_file ]] && jq -e '(.Expiration | sub("\\+00:00$"; "Z") | fromdateiso8601) > now' "$cache_file" >/dev/null 2>&1; then
	cat "$cache_file"
	exit 0
fi

# `--format json` + `jq` is preferable to parsing a human-readable table.
# `--arg name "$secret_name"` passes the value as data instead of interpolating.
# `head -1` picks the first of potentially multiple results.
secret_id=$(op item list --vault "$vault" --format json |
	jq -r --arg name "$secret_name" '.[] | select(.title | contains($name)) | .id' |
	head -1)
echo "Secret ID: $secret_id" >&2

device=$(op item get --fields label='otp ARN' "$secret_id")
echo "Device ARN: $device" >&2

otp=$(op item get --otp "$secret_id")
echo "TOTP: $otp" >&2

# 12 hours is the maximum time STS allows for IAM users with an MFA device.
output=$(aws --profile "$profile" sts get-session-token \
	--serial-number "$device" \
	--token-code "$otp" \
	--duration-seconds 43200 |
	jq -c '{
    Version: 1,
    AccessKeyId: .Credentials.AccessKeyId,
    SecretAccessKey: .Credentials.SecretAccessKey,
    SessionToken: .Credentials.SessionToken,
    Expiration: .Credentials.Expiration
  }')
echo "$output"

# Cache the credentials for the future.
mkdir -p "${cache_file:h}"
echo "$output" >"$cache_file"
