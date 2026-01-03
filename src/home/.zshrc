# Use an anonymous function for scoping.
function {
  # Profiling
  # =========

  # Note: This needs to be at the top of the file.
  if [[ "${ENABLE_ZSH_PROFILING}" == true ]]; then
    zmodload zsh/zprof
  fi

  # Package Management
  # ==================

  # Since `.zprofile` doesn't appear to be loaded on Ubuntu init Homebrew here.
  if [[ "$(uname)" == 'Linux' ]] \
    && [[ -x '/home/linuxbrew/.linuxbrew/bin/brew' ]]
  then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi

  # Environment Variables
  # =====================

  # Set additional environment variables which can't be set in `.zshenv` because
  # they depend on the Homebrew environment, which is initialized in `.zprofile`
  # (or above), which is loaded after `.zshenv`.

  # Set Cargo config.
  # See: https://doc.rust-lang.org/cargo/reference/environment-variables.html
  if (( $+commands[cargo] )); then
    export CARGO_HOME="${XDG_DATA_HOME}/cargo"
  fi

  # Set Go config.
  # See: https://go.dev/wiki/SettingGOPATH
  if (( $+commands[go] )); then
    export GOPATH="${XDG_DATA_HOME}/go"
  fi

  # Add items to the path.
  if [[ -d "${HOME}/.local/bin" ]] && (( ! $path[(Ie)${HOME}/.local/bin] )); then
    path=("${HOME}/.local/bin" $path)
  fi

  if [[ -n "${CARGO_HOME}" ]] && (( ! $path[(Ie)${CARGO_HOME}/bin] )); then
    path+=("${CARGO_HOME}/bin")
  fi

  if [[ -n "${GOPATH}" ]] && (( ! $path[(Ie)${GOPATH}/bin] )); then
    path+=("${GOPATH}/bin")
  fi

  local -r application_support="${HOME}/Library/Application Support"

  if [[ "$(uname)" == 'Darwin' ]] \
    && [[ -d "${application_support}/JetBrains/Toolbox/scripts" ]] \
    && (( ! $path[(Ie)${application_support}/JetBrains/Toolbox/scripts] ))
  then
    path+=("${application_support}/JetBrains/Toolbox/scripts")
  fi

  export PATH

  # Set the appropriate visual editor.
  if [[ -z "${SSH_CONNECTION}" ]] && (( $+commands[code] )); then
    export VISUAL='code --wait'
  else
    export VISUAL="${EDITOR}"
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
  if [[ "${ENABLE_WHIMSICAL_GREETING}" == true ]] \
    && [[ "${IN_EDITOR_TERMINAL}" == false ]] \
    && (( $+commands[figlet] )) \
    && (( $+commands[lolcat] ))
  then
    figlet -f isometric4 'Hello World' | lolcat
  fi

  # Command Line Completion
  # =======================

  # Add Homebrew completions to `$FPATH`.
  local -r site_functions="$(brew --prefix)/share/zsh/site-functions"

  if [[ -d "${site_functions}" ]] && (( ! $fpath[(Ie)$site_functions] )); then
    fpath=($site_functions $fpath)
  fi

  # We don't need to export `$FPATH` since we invoke `compinit` directly below.
  # export FPATH

  # Reinitialize command line completion. Of note, Zsh formally recommends using
  # `autoload -U compinit` instead of `autoload -Uz compinit` on their homepage.
  # See: https://thevaluable.dev/zsh-completion-guide-examples/
  if autoload -U compinit; then
    compinit
  fi

  # Profiling
  # =========

  # Note: This needs to be at the bottom of the file.
  if [[ "${ENABLE_ZSH_PROFILING}" == true ]]; then
    zprof
  fi
}
