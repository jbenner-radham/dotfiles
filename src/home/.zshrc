# Note: This needs to be at the top of the file.
if [[ "${ENABLE_ZSH_PROFILING}" = true ]]; then
  zmodload zsh/zprof
fi

# Set additional environment variables which can't be set in `.zshenv` because
# they depend on the Homebrew environment, which is initialized in `.zprofile`,
# which is loaded after `.zshenv`.

# Add items to the path.
if [[ -d "${HOME}/.local/bin" ]]; then
  path=("${HOME}/.local/bin" $path)
fi

if [[ "${OSTYPE}" == darwin* ]] \
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

# Input/Output Options
# See: https://zsh.sourceforge.io/Doc/Release/Options.html#Input_002fOutput
unsetopt SHORT_LOOPS # Short loops limit the parser's ability to detect errors.

# Since `.zprofile` doesn't appear to be loaded on Ubuntu init Homebrew here.
if [[ "${OSTYPE}" = linux* ]] \
  && [[ -x '/home/linuxbrew/.linuxbrew/bin/brew' ]]
then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Ensure the XDG runtime directory exists and has the appropriate permissions.
if [[ -n "${XDG_RUNTIME_DIR}" ]]; then
  mkdir -p "${XDG_RUNTIME_DIR}"
  chmod 700 "${XDG_RUNTIME_DIR}"
fi

# The parenthesized characters are called glob qualifiers and do the following:
#  .: Match only plain files.
#  N: Set the `NULL_GLOB` option for the current pattern. This will suppress the
#     error raised when no files match the current pattern.
#  r: Match only owner-readable files.
# See: https://zsh.sourceforge.io/Doc/Release/Expansion.html#Glob-Qualifiers
# Note: The glob won't work if it's quoted.
# for file in $XDG_CONFIG_HOME/zsh/*.zsh(.Nr); do
#   source "${file}"
# done

# Unset our loop variable so it doesn't persist in our shell session.
# unset file

# Setup Integrations
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

if (( $+commands[sheldon] )); then
  eval "$(sheldon source)"
fi

if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

# A Little Fun
if [[ "${ENABLE_COWSAY_GREETING}" = true ]] \
  && (( $+commands[cowsay] )) \
  && (( $+commands[fortune] ))
then
  cowsay "$(fortune)"
fi

# Reinitialize Command Line Completion
# See: https://thevaluable.dev/zsh-completion-guide-examples/
autoload -Uz compinit && compinit

# Note: This needs to be at the bottom of the file.
if [[ "${ENABLE_ZSH_PROFILING}" = true ]]; then
  zprof
fi
