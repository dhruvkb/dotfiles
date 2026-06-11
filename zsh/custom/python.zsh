# Python configuration
# ====================

# uv
# ==

# Configure uv to use XDG data directory for tool bins, similar to Cargo.
export UV_TOOL_BIN_DIR="$XDG_DATA_HOME/uv/tools_bin/"

# Load uv tool binaries on the path.
pathadd "$UV_TOOL_BIN_DIR"

# Configure uv to use XDG data directory for managed Python binaries.
export UV_PYTHON_BIN_DIR="$XDG_DATA_HOME/uv/python_bin/"

# Place uv Python binaries on the path, before other entries. This is because
# Homebrew also installs Python and we don't want it to take precedence.
pathadd -p "$UV_PYTHON_BIN_DIR"

# IPython
# =======
