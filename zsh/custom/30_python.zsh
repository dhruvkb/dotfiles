# Python configuration
# ====================

# pipx
# ====

# Make pipx folder structure similar to that of Homebrew.
export PIPX_HOME="/opt/pipx"
export PIPX_BIN_DIR="$PIPX_HOME/bin"

# Load pipx binaries on the path.
pathadd "$PIPX_BIN_DIR"

# IPython
# =======
