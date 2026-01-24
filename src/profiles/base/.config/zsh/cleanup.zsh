# Remove Less' history file.
if [[ "${LESSHISTFILE}" == '-' ]]; then
  if [[ -f "${HOME}/.lesshst" ]]; then
    rm "${HOME}/.lesshst"
  fi

  if [[ -f "${XDG_STATE_HOME}/lesshst" ]]; then
    rm "${XDG_STATE_HOME}/lesshst"
  fi
fi

# Remove Apple's "Save/Restore Shell State" feature directory.
if [[ -n "${SHELL_SESSIONS_DISABLE}" ]]; then
  rm -rf "${ZDOTDIR:-$HOME}/.zsh_sessions"
fi

# Cleanup the default history file since it likes to keep sneaking back.
if [[ -f "${ZDOTDIR:-$HOME}/.zsh_history" ]]; then
  rm "${ZDOTDIR:-$HOME}/.zsh_history"
fi
