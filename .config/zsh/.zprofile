export PYENV_ROOT="$HOME/.local/pyenv"
export PATH="$PYENV_ROOT/bin:$HOME/.local/poetry/bin:$PATH:$HOME/.local/bin"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

eval `keychain --eval --agents ssh id_rsa id_ed25519`
