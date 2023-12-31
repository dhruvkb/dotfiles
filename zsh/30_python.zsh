# Python configuration
# ====================

export PIPX_HOME="/opt/pipx"
export PIPX_BIN_DIR="$PIPX_HOME/bin"

# Load pipx binaries on the path, includes utils like HTTPie, Poetry and Pipenv.
pathadd "$PIPX_BIN_DIR"
