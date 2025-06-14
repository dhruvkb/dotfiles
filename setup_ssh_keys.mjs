#!/usr/bin/env zx

const SSH_KEYS = [
	["Personal", "Ed25519"],
	["Automattic", "Ed25519 (A8c)"],
	["FinRep", "Ed25519 (FinRep)"],
]

/**
 * Get the secret ID for the SSH key.
 *
 * @param {string} vault the vault name
 * @param {string} item the item name
 * @returns {string} the secret ID for the SSH key
 */
async function getSecretId(vault, item) {
	const secretId = await $`op item list --vault ${vault} | grep ${item} | awk '{print $1}'`
	return secretId
}

/**
 * Extract the public key from the vault item.
 *
 * @param {string} vault the vault name
 * @param {string} item the item name
 * @returns {string} the public key for the SSH key
 */
async function getPublicKey(vault, item) {
	const secretId = await getSecretId(vault, item)
	const publicKey = await $`op item get ${secretId} --vault ${vault} --fields 'public key'`
	return publicKey
}

for (const sshKey of SSH_KEYS) {
	const [vault, item] = sshKey
	console.log(`Writing public key for ${vault}/${item}.`)
	const pubKey = await getPublicKey(vault, item)
	$`echo ${pubKey} > ~/.ssh/id_ed25519_${vault.toLocaleLowerCase()}.pub`
}
