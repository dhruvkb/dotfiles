# If this is turned off, `locale` reverts everything to "C".
export LANG="en_US.UTF-8"

# Set preferred editor for local and remote sessions.
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim -f'
fi
