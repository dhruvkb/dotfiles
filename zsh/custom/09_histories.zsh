# This file configures history destinations for software to match the
# XDG specification.

# Make Zsh write history to XDG-compatible path.
export HISTFILE="$XDG_STATE_HOME/zsh/history"

# Make less write history to XDG-compatible path.
export LESSHISTFILE="$XDG_STATE_HOME/lesshst"

# Make Node.js REPL write history to XDG-compatible path.
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"

# Make PSQL write history to XDG-compatible path.
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"

# Make Python write history to XDG-compatible path.
# This is only supported on Python 3.13 and above.
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"

# Make Redis write history to XDG-compatible path.
export REDISCLI_HISTFILE="$XDG_STATE_HOME/redis/rediscli_history"
