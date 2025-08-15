# Profiling
# =========

# Note: This needs to be at the top of the file.
if [[ "${ENABLE_ZSH_PROFILING}" = true ]]; then
  zmodload zsh/zprof
fi

# Environment Variables
# =====================

# Set additional environment variables which can't be set in `.zshenv` because
# they depend on the Homebrew environment, which is initialized in `.zprofile`,
# which is loaded after `.zshenv`.

# Add items to the path.
if [[ -d "${HOME}/.local/bin" ]]; then
  path=("${HOME}/.local/bin" $path)
fi

if [[ "$(uname)" == 'Darwin' ]] \
  && [[ -d "${HOME}/Library/Application Support/JetBrains/Toolbox/scripts" ]]
then
  path+=("${HOME}/Library/Application Support/JetBrains/Toolbox/scripts")
fi

export PATH

# Set the appropriate visual editor.
if [[ -z "${SSH_CONNECTION}" ]] && (( $+commands[code] )); then
  export VISUAL='code --wait'
else
  export VISUAL="${EDITOR}"
fi

# Set the preferred pager.
if (( $+commands[bat] )); then
  export PAGER='bat'
else
  export PAGER='less'
fi

# Set the preferred man pager.
if (( $+commands[nvim] )); then
  # Not nicely colorized like `less`, but worth it just for the `gO` command.
  export MANPAGER='nvim +Man!'
else
  # The default is `less -sR`, the added flags enable percentage display.
  # Colorization is configured via the `LESS_TERMCAP_*` environment variables.
  export MANPAGER='less -MRs +Gg'

  # Required to colorize man pages viewed via `less` on Ubuntu.
  export GROFF_NO_SGR=1
fi

# Options
# =======

# Expansion and Globbing Options
# See: https://zsh.sourceforge.io/Doc/Release/Options.html#Expansion-and-Globbing

# Do not print a warning message when a global parameter is created in a
# function by an assignment or in math context.
unsetopt WARN_CREATE_GLOBAL # Starship creates globals.

# Input/Output Options
# See: https://zsh.sourceforge.io/Doc/Release/Options.html#Input_002fOutput

# Disallow the short forms of for, repeat, select, if, and function constructs.
unsetopt SHORT_LOOPS # Short loops limit the parser's ability to detect errors.

# Package Management
# ==================

# Since `.zprofile` doesn't appear to be loaded on Ubuntu init Homebrew here.
if [[ "$(uname)" == 'Linux' ]] \
  && [[ -x '/home/linuxbrew/.linuxbrew/bin/brew' ]]
then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# XDG Runtime Directory
# =====================

# Ensure the XDG runtime directory exists and has the appropriate permissions.
if [[ -n "${XDG_RUNTIME_DIR}" ]]; then
  mkdir -p "${XDG_RUNTIME_DIR}"
  chmod 700 "${XDG_RUNTIME_DIR}"
fi

# Plugin Management
# =================

# Setup Sheldon
if (( $+commands[sheldon] )); then
  eval "$(sheldon source)"
fi

# Whimsical Greeting
# ==================

# A Little Fun
if [[ "${ENABLE_COWSAY_GREETING}" = true ]] \
  && [[ "${IN_EDITOR_TERMINAL}" = false ]] \
  && (( $+commands[cowsay] )) \
  && (( $+commands[fortune] ))
then
  cowsay "$(fortune)"
fi

# Command Line Completion
# =======================

# Add Homebrew completions to `$FPATH`.
if [[ "$(uname)" = 'Darwin' ]] \
  && [[ -d /opt/homebrew/share/zsh/site-functions ]] \
  && (( ! $fpath[(Ie)/opt/homebrew/share/zsh/site-functions] ))
then
  fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
elif [[ "$(uname)" = 'Linux' ]] \
  && [[ -d /home/linuxbrew/.linuxbrew/share/zsh/site-functions ]] \
  && (( ! $fpath[(Ie)/home/linuxbrew/.linuxbrew/share/zsh/site-functions] ))
then
  fpath=(/home/linuxbrew/.linuxbrew/share/zsh/site-functions $fpath)
fi

export FPATH

# Reinitialize command line completion.
# See: https://thevaluable.dev/zsh-completion-guide-examples/
autoload -Uz compinit && compinit

# Profiling
# =========

# Note: This needs to be at the bottom of the file.
if [[ "${ENABLE_ZSH_PROFILING}" = true ]]; then
  zprof
fi
