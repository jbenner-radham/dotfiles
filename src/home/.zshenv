# Profiling
# =========

# Enable profiling using `zprof`.
# export ENABLE_ZSH_PROFILING=true

# Whimsical Greeting
# ==================

# Display cowsay greeting with fortune quotes in the shell.
export ENABLE_COWSAY_GREETING=true

# Eza Configuration
# =================

# Used by Eza for time formatting.
# See: https://docs.rs/chrono/latest/chrono/format/strftime/index.html
export TIME_STYLE="+%b %d %Y %I:%M:%S%P"

# Language
# ========

if [[ -z "${LANG}" ]]; then
  export LANG='en_US.UTF-8'
fi

# XDG Base Directory Specification
# ================================

# See: https://specifications.freedesktop.org/basedir-spec/latest/

if [[ -z "${XDG_CACHE_HOME}" ]]; then
  # TODO: Maybe set to `"${HOME}/Library/Caches"` on macOS?
  export XDG_CACHE_HOME="${HOME}/.cache"
fi

if [[ -z "${XDG_CONFIG_HOME}" ]]; then
  # TODO: Maybe set to `"${HOME}/Library/Application Support"` on macOS?
  export XDG_CONFIG_HOME="${HOME}/.config"
fi

if [[ -z "${XDG_DATA_HOME}" ]]; then
  export XDG_DATA_HOME="${HOME}/.local/share"
fi

if [[ -z "${XDG_STATE_HOME}" ]]; then
  export XDG_STATE_HOME="${HOME}/.local/state"
fi

if [[ -z "${XDG_RUNTIME_DIR}" ]]; then
  if [[ "$(uname)" == 'Darwin' ]]; then
    # `$TMPDIR` ends with a forward slash so we strip it off via `%/`.
    export XDG_RUNTIME_DIR="${TMPDIR%/}/runtime-${UID}"
  elif [[ "$(uname)" == 'Linux' ]]; then
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
  fi
fi

# Oh My Zsh Configuration
# =======================

# Set the Oh My Zsh cache directory. My completions script is sourced from
# Oh My Zsh, otherwise I wouldn't need it.
# See: https://github.com/ohmyzsh/ohmyzsh/wiki/Settings#zsh_cache_dir
export ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"

# Homebrew Configuration
# ======================

# Define path to `Brewfile` for Homebrew.
export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/homebrew/Brewfile"

# Editor
# ======

# Set the preferred editor.
export EDITOR='vim'

# Note: Some additional environment variables are set in `.zshrc`.
