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

# History
# =======

if [[ -z "${HISTFILE}" ]]; then
  export HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
fi

if [[ -z "${HISTSIZE}" ]] || (( HISTSIZE < 50000 )); then
  export HISTSIZE=50000
fi

if [[ -z "${SAVEHIST}" ]] || (( SAVEHIST < 10000 )); then
  export SAVEHIST=10000
fi

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

# Less Configuration
# ==================

# Turn off command and search history.
export LESSHISTFILE=-

# Enable to see the `TERMCAP`s used in a man page.
# export LESS_TERMCAP_DEBUG=1

# Configure text styling when using `less` as a man pager.
# See: `man 5 terminfo` (search TCap Code e.g., mb, md, etc.)
#
# TODO: Use `${HOME}/.lesskey` to store these so they don't mess with the
# environment when running `env`. Maybe build a `.lesskey` file during
# `make install`?

# Turn on blinking.
export LESS_TERMCAP_mb="$(tput blink)"

# Turn on bold (extra bright) mode.
export LESS_TERMCAP_md="$(tput bold; tput setaf 2)" # Bold green.

# Turn off all attributes.
export LESS_TERMCAP_me="$(tput sgr0)"

# Turn on half-bright mode.
export LESS_TERMCAP_mh="$(tput dim)"

# Turn on reverse video mode.
export LESS_TERMCAP_mr="$(tput rev)" # Invert colors.

# Exit standout mode.
export LESS_TERMCAP_se="$(tput rmso; tput sgr0)"

# Begin standout mode.
export LESS_TERMCAP_so="$(tput bold; tput setaf 3)" # Bold yellow.

# Exit underline mode.
export LESS_TERMCAP_ue="$(tput rmul; tput sgr0)"

# Begin underline mode.
export LESS_TERMCAP_us="$(tput smul; tput bold; tput setaf 1)" # Underlined bold red.

# Enter subscript mode.
export LESS_TERMCAP_ZN="$(tput ssubm)"

# Enter superscript mode.
export LESS_TERMCAP_ZO="$(tput ssupm)"

# End subscript mode.
export LESS_TERMCAP_ZV="$(tput rsubm)"

# End superscript mode.
export LESS_TERMCAP_ZW="$(tput rsupm)"

# Editor
# ======

# Set the preferred editor.
export EDITOR='vim'

# Determine if we're operating within an editor terminal.
if [[ "${TERM_PROGRAM}" = 'Jetbrains.Fleet' ]] \
  || [[ "${TERM_PROGRAM}" = 'vscode' ]] \
  || [[ "${TERMINAL_EMULATOR}" = 'JetBrains-JediTerm' ]]
then
  export IN_EDITOR_TERMINAL=true
else
  export IN_EDITOR_TERMINAL=false
fi

# Note: Some additional environment variables are set in `.zshrc`.
