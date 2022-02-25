# Pyenv configuration
eval "$(pyenv init --path)"

# Load pipx binaries on the path, includes utils like HTTPie, Poetry and Pipenv
export PATH="$PATH:$HOME/.local/bin"

# Configure Pipenv to play nice with Pyenv
export PIPENV_PYTHON="$(pyenv root)/shims/python"
