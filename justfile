# Show all available recipes
@_default:
	just --list --unsorted

# Install packages with uv.
install:
	uv sync

# Run `prek` commands through uv.
prek *args:
	uv run prek {{ args }}

# Run `prek` to lint and format files.
lint hook="" *files="":
	just prek run {{ hook }} {{ if files == "" { "--all-files" } else { "--files" } }} {{ files }}

###########
# Aliases #
###########

alias l := lint
