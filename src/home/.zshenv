# Enable profiling using `zprof`.
# export ENABLE_ZSH_PROFILING=true

# Used by Eza for time formatting.
# See: https://docs.rs/chrono/latest/chrono/format/strftime/index.html
export TIME_STYLE="+%b %d %Y %I:%M:%S%P"

# Set the XDG Base Directory environment variables.
# See: https://specifications.freedesktop.org/basedir-spec/latest/
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

if [[ $(uname) = 'Darwin' ]]; then
  # `$TMPDIR` ends with a forward slash so we strip it off via `%/`.
  export XDG_RUNTIME_DIR="${TMPDIR%/}/runtime-${UID}"
elif [[ "$(uname)" = 'Linux' ]]; then
  export XDG_RUNTIME_DIR="/run/user/$(id -u)"
fi

# Set the Oh My Zsh cache directory. My completions script is sourced from
# Oh My Zsh, otherwise I wouldn't need it.
# See: https://github.com/ohmyzsh/ohmyzsh/wiki/Settings#zsh_cache_dir
export ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"

# Add items to the path.
[[ -d "${HOME}/.local/bin" ]] && path=("${HOME}/.local/bin" $path)
[[ $(uname) = 'Darwin' ]] &&
  [[ -d "${HOME}/Library/Application Support/JetBrains/Toolbox/scripts" ]] &&
  path+=("${HOME}/Library/Application Support/JetBrains/Toolbox/scripts")
export PATH
