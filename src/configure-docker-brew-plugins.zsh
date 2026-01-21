#!/usr/bin/env zsh

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

# Enable this to assist with debugging errors.
# set -o xtrace

function {
  if (( ! $+commands[jq] )); then
    print 'Cannot find `jq`, please install it and try again.' >&2
    return 1
  fi

  local prefix

  prefix="$(brew --prefix)"

  local -r config_filepath="${HOME}/.docker/config.json"
  local -r plugins_filepath="${prefix}/lib/docker/cli-plugins"

  if [[ ! -f "${config_filepath}" ]]; then
    print 'No Docker config file found. Start Docker to have one created.'
    return 0
  fi

  if $(
    jq --exit-status \
      --arg filepath "${plugins_filepath}" \
      '.cliPluginsExtraDirs // [] | any(. == $filepath)' \
      "${config_filepath}" \
      >/dev/null
  ); then
    print 'Docker `brew` plugins are already configured! 🎉'
    return 0
  fi

  local config_json

  config_json=$(
    jq --tab \
      --arg filepath "${plugins_filepath}" \
      --arg prop 'cliPluginsExtraDirs' \
      '
        if (has($prop) and (.[$prop] | type == "array")) then
          .[$prop] += [$filepath]
        else
          . + {($prop): [$filepath]}
        end
      ' \
    "${config_filepath}")

  print "${config_json}" > "${config_filepath}"
}
