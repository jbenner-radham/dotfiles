# Enable profiling using `zprof`.
# export ENABLE_ZSH_PROFILING=true

# Display cowsay greeting with fortune quotes in the shell.
export ENABLE_COWSAY_GREETING=true

# Used by Eza for time formatting.
# See: https://docs.rs/chrono/latest/chrono/format/strftime/index.html
export TIME_STYLE="+%b %d %Y %I:%M:%S%P"

# Set the language.
if [[ -z "${LANG}" ]]; then
  export LANG='en_US.UTF-8'
fi

# Set the XDG Base Directory environment variables.
# See: https://specifications.freedesktop.org/basedir-spec/latest/
if [[ -z "${XDG_CACHE_HOME}" ]]; then
  export XDG_CACHE_HOME="${HOME}/.cache"
fi

if [[ -z "${XDG_CONFIG_HOME}" ]]; then
  export XDG_CONFIG_HOME="${HOME}/.config"
fi

if [[ -z "${XDG_DATA_HOME}" ]]; then
  export XDG_DATA_HOME="${HOME}/.local/share"
fi

if [[ -z "${XDG_STATE_HOME}" ]]; then
  export XDG_STATE_HOME="${HOME}/.local/state"
fi

if [[ -z "${XDG_RUNTIME_DIR}" ]]; then
  if [[ "${OSTYPE}" == darwin* ]]; then
    # `$TMPDIR` ends with a forward slash so we strip it off via `%/`.
    export XDG_RUNTIME_DIR="${TMPDIR%/}/runtime-${UID}"
  elif [[ "${OSTYPE}" = linux* ]]; then
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
  fi
fi

# Set the Oh My Zsh cache directory. My completions script is sourced from
# Oh My Zsh, otherwise I wouldn't need it.
# See: https://github.com/ohmyzsh/ohmyzsh/wiki/Settings#zsh_cache_dir
export ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"

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

# Define path to `Brewfile` for Homebrew.
export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/homebrew/Brewfile"

# Set the preferred editor(s).
export EDITOR='vim'

# For some reason on macOS the Homebrew paths aren't available in the path yet
# so we can't use `$+commands[code]` to look for the VS Code launcher.
if [[ -z "${SSH_CONNECTION}" ]] && [[ -x /opt/homebrew/bin/code ]]; then
  export VISUAL='code --wait'
else
  export VISUAL="${EDITOR}"
fi
