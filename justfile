# Show all available recipes
@_default:
    just --list --unsorted

#######
# Dev #
#######

# Install all Python dependencies using PDM
install:
	pdm install

# Install Git hooks for pre-commit
precommit: install
	pdm run \
		pre-commit install

# Run pre-commit to lint and reformat files
lint hook="" *files="":
	pdm run \
		pre-commit run \
			{{ hook }} \
			{{ if files == "" { "--all-files" } else { "--files" } }} {{ files }}

#########
# Setup #
#########

# Setup dev environment
dev:
	./dev_env/brew_install.sh
	./dev_env/pipx_install.sh

# Setup iTerm2
iterm:
    ./iterm/setup_iterm.sh

# Run Python scripts inside PDM context
py *args:
	pdm run python {{ args }}

# Setup Vim
vim:
	just py vim/setup_vim.py

# Setup Git
git:
	just py git/setup_git.py

# Setup SSH
ssh:
	just py ssh/setup_ssh.py

# Setup Zsh
zsh:
	just py zsh/setup_zsh.py

###########
# Aliases #
###########

alias l := lint
