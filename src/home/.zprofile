# Package Management
# ==================

# On macOS init Homebrew here. See the `.zshrc` for the Ubuntu init.
if [[ "$(uname)" == 'Darwin' ]] && [[ -x '/opt/homebrew/bin/brew' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
