# Editor
# ======

# Set preferred editor for local and remote sessions. We prefer `hx` over `vim` over `vi`.
if $(command -v hx &>/dev/null); then
  export EDITOR="hx"
elif $(command -v vim &>/dev/null); then
  export EDITOR="vim"
else
  export EDITOR="vi"
fi

alias hx='$EDITOR'
alias vim='$EDITOR'
alias vi='$EDITOR'
