#!/usr/bin/env zsh

function {
  emulate -L zsh

  setopt ERR_EXIT  # Exit on error.
  setopt NO_UNSET  # Error on undefined variables.
  setopt PIPEFAIL  # Fail on any pipe command failure.

  # Enable this to assist with debugging errors.
  # setopt XTRACE  # Print commands and their arguments as they are executed.

  function is-claude-plugin-enabled() {
    local -r plugin="${1}"

    claude plugin list --json \
      | jq --arg plugin "${plugin}" '.[] | select(.id == ''$plugin'').enabled'
  }

  if (( $+commands[claude] )); then
    if (( $+commands[rust-analyzer] )); then
      claude plugin install rust-analyzer-lsp@claude-plugins-official

      if [[ $(is-claude-plugin-enabled 'rust-analyzer-lsp@claude-plugins-official') != true ]]; then
        claude plugin enable rust-analyzer-lsp@claude-plugins-official
      fi
    fi

    if (( $+commands[typescript-language-server] )); then
      claude plugin install typescript-lsp@claude-plugins-official

      if [[ $(is-claude-plugin-enabled 'typescript-lsp@claude-plugins-official') != true ]]; then
        claude plugin enable typescript-lsp@claude-plugins-official
      fi
    fi
  fi
}
