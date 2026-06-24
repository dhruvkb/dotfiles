# Show all available recipes.
@_default:
	just --list --unsorted

# Install dependencies.
install:
	pnpm i

# Run `prek` commands through package manager.
prek *args:
	pnpm exec prek {{ args }}

# Run `prek` to lint and format files.
lint hook="" *files="":
	just prek run {{ hook }} {{ if files == "" { "--all-files" } else { "--files" } }} {{ files }}

###########
# Aliases #
###########

alias l := lint
