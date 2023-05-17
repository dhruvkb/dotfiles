# Python configuration
# ====================

# Load pipx binaries on the path, includes utils like HTTPie, Poetry and Pipenv.
export PIPX_HOME="/opt/pipx"
export PIPX_BIN_DIR="$PIPX_HOME/bin"
export PATH="$PATH:$PIPX_BIN_DIR"
