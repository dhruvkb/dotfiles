# Editor
# ======

# Set preferred editor for local and remote sessions. The order of preference is
# `hx` > `vim` > `vi`.
#
# We use `$+commands` because it checks for real executables only and does not
# match the aliases defined below.
if (($+commands[hx])); then
	export EDITOR="hx"
elif (($+commands[vim])); then
	export EDITOR="vim"
else
	export EDITOR="vi"
fi

# Aliases
alias hx='$EDITOR'
alias vim='$EDITOR'
alias vi='$EDITOR'
