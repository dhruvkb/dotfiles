# OrbStack
# ========

# Update $PATH to include CLI tools like `docker`, `kubectl`, `orb` etc.
if [ -e "$HOME/.orbstack/shell/init.zsh" ]; then
  source "$HOME/.orbstack/shell/init.zsh"
else
  echo "OrbStack not found."
fi
