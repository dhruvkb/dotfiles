# Show all available recipes
@_default:
    just --list --unsorted

########
# Dev #
########

# Install all Python dependencies using Poetry
install:
	poetry install

# Install Git hooks for pre-commit
precommit: install
	poetry run \
		pre-commit install

# Run pre-commit to lint and reformat files
lint hook="" *files="":
	poetry run \
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

# Setup Vim
vim:
	python3 vim/setup_vim.py

# Setup Git
git:
	python3 git/setup_git.py

# Setup SSH
ssh:
	python3 ssh/setup_ssh.py

# Setup Zsh
zsh:
	python3 zsh/setup_zsh.py

###########
# Aliases #
###########

alias l := lint
