# Profiling
# =========

# Enable profiling using `zprof`.
# export ENABLE_ZSH_PROFILING=true

# Whimsical Greeting
# ==================

# Display a fun greeting in the shell at the start of a new session.
export ENABLE_WHIMSICAL_GREETING=true

# Eza Configuration
# =================

# Used by Eza for time formatting.
# See: https://docs.rs/chrono/latest/chrono/format/strftime/index.html
export TIME_STYLE="+%b %d %Y %I:%M:%S%P"

# History
# =======

# The history related environment variables are set in
# `$HOME/.config/zsh/history.zsh` because on macOS they get overwritten by
# `/etc/zshrc` if set here.

# Language
# ========

if [[ -z "${LANG}" ]]; then
  export LANG='en_US.UTF-8'
fi

# macOS Configuration
# ===================

if [[ "$(uname)" == 'Darwin' ]]; then
  # Disable Apple's "Save/Restore Shell State" feature for `Terminal.app`. This
  # prevents writing to `$HOME/.zsh_sessions` and is unnecessary if the
  # `SHARE_HISTORY` option is set.
  export SHELL_SESSIONS_DISABLE=1
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

# Less Configuration
# ==================

# Turn off command and search history.
export LESSHISTFILE=-

# Enable to see the `TERMCAP`s used in a man page.
# export LESS_TERMCAP_DEBUG=1

# Editor
# ======

# Set the preferred editor.
export EDITOR='vim'

# Determine if we're operating within an editor terminal.
if [[ "${TERMINAL_EMULATOR}" == 'JetBrains-JediTerm' ]] \
  || [[ "${TERM_PROGRAM}" == 'Jetbrains.Fleet' ]] \
  || [[ "${TERM_PROGRAM}" == 'vscode' ]]
then
  export IN_EDITOR_TERMINAL=true
else
  export IN_EDITOR_TERMINAL=false
fi

# Manpager
# ========

# Supposedly the default is `less -sR`, the added flags enable location
# percentage display. Colorization is configured via the `LESS_TERMCAP_*`
# variables in `$HOME/.lesskey`. Note that on macOS, these variables are only
# read if `less` is installed via Homebrew.
export MANPAGER='less -MRs +Gg'

# Required to colorize man pages viewed via `less` on Ubuntu.
export GROFF_NO_SGR=1

# Note: Some additional environment variables are set in `.zshrc`.
