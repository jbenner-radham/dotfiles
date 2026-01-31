#!/usr/bin/env zsh

function {
  emulate -L zsh

  setopt ERR_EXIT  # Exit on error.
  setopt NO_UNSET  # Error on undefined variables.
  setopt PIPEFAIL  # Fail on any pipe command failure.

  # Enable this to assist with debugging errors.
  # setopt XTRACE  # Print commands and their arguments as they are executed.

  if (( $+commands[claude] )); then
    if (( $+commands[typescript-language-server] )); then
      claude plugin install typescript-lsp@claude-plugins-official

      if [[ $(claude plugin list --json | jq '.[] | select(.id == "typescript-lsp@claude-plugins-official").enabled') != true ]]; then
        claude plugin enable typescript-lsp@claude-plugins-official
      fi
    fi
  fi
}
