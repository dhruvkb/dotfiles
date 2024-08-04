# Show all available recipes
@_default:
    just --list --unsorted

#######
# Dev #
#######

# Setup pre-commit as a Git hook
precommit:
	#!/usr/bin/env bash
	set -eo pipefail
	if [ -z "$SKIP_PRE_COMMIT" ] && [ ! -f ./pre-commit.pyz ]; then
		echo "Getting latest release"
		curl \
			${GITHUB_TOKEN:+ --header "Authorization: Bearer ${GITHUB_TOKEN}"} \
			--output latest.json \
			https://api.github.com/repos/pre-commit/pre-commit/releases/latest
		cat latest.json
		URL=$(grep -o 'https://.*\.pyz' -m 1 latest.json)
		rm latest.json
		echo "Downloading pre-commit from $URL"
		curl \
			--fail \
			--location `# follow redirects, else cURL outputs a blank file` \
			--output pre-commit.pyz \
			${GITHUB_TOKEN:+ --header "Authorization: Bearer ${GITHUB_TOKEN}"} \
			"$URL"
		echo "Installing pre-commit"
		python3 pre-commit.pyz install -t pre-push -t pre-commit
		echo "Done"
	else
		echo "Skipping pre-commit installation"
	fi

# Run pre-commit to lint and reformat files
lint hook="" *files="": precommit
	python3 pre-commit.pyz run {{ hook }} {{ if files == "" { "--all-files" } else { "--files" } }}  {{ files }}

###########
# Aliases #
###########

alias l := lint
