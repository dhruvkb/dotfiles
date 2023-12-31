#!/bin/bash

vault="$1"
secret_name="$2"
secret_id=$(op item list --vault ${vault} | grep "${secret_name}" | awk '{print $1}')

cat <<EOF | op inject
{
  "Version": 1,
  "AccessKeyId": "{{ op://${vault}/${secret_id}/access key id }}",
  "SecretAccessKey": "{{ op://${vault}/${secret_id}/secret access key }}"
}
EOF
