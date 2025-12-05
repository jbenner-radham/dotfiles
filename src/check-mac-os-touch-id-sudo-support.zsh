#!/usr/bin/env zsh

set -o errexit
set -o noglob
set -o nounset
set -o pipefail

# Enable this to assist with debugging errors.
# set -o xtrace

# Print the provided message to stderr in red.
#
# Arguments:
#   An error message.
function print-error() {
  printf '%sError: %s%s\n' "$(tput setaf 1)" "${1}" "$(tput sgr0)" >&2
}

# Print the provided message to stdout in green.
#
# Arguments:
#   An info message.
function print-info() {
  printf '%sInfo: %s%s\n' "$(tput setaf 2)" "${1}" "$(tput sgr0)"
}

# Print a success message once Touch ID support for `sudo` has been confirmed or
# configured.
function print-success-message() {
    local message=$(
      printf '%s %s %s %s' \
        'macOS is configured to allow Touch ID for `sudo`!' \
        'Ensure iTerm is configured to allow this by going into' \
        '"Settings" > "Advanced" and making sure' \
        '"Allow sessions to survive logging out and back in" is set to "No".'
    )

    print $message
}

function main() {
  # `%#` returns a `#` if running in a privileged shell and a '%' in an
  # unprivileged shell.
  #
  # The `-P` flag of `print` prints the output in a way that is suitable for
  # further processing (like `printf`).
  if [[ $(print -P %#) == '%' ]]; then
    print-error 'Please run this script with `sudo`.'
    exit 1
  fi

  local -r sudo_local='/etc/pam.d/sudo_local'
  local -r sudo_local_template='/etc/pam.d/sudo_local.template'

  if [[ ! -f "${sudo_local}" ]]; then
    local message=$(
      printf '%s %s' \
        'The `sudo_local` file is not present.' \
        'Copying over the template...'
    )

    print-info $message
    cp $sudo_local_template $sudo_local
  fi

  # See: https://zsh.sourceforge.io/Doc/Release/Zsh-Modules.html#The-zsh_002fpcre-Module
  zmodload zsh/pcre

  # The `f` parameter expansion flag splits the result of the expansion at
  # newlines. This is a shorthand for `ps:\n:`.
  local -r lines=("${(f)$(<${sudo_local})}")
  local pattern='^auth\s+sufficient\s+pam_tid.so$'

  pcre_compile $pattern

  for line in $lines; do
    # We short-circuit here because otherwise the script would exit due to
    # `set -o errexit` being set. Alternatively, we could set `set +errexit`
    # before `pcre_match` to disable this behavior and re-enable it afterwards.
    pcre_match $line && true
  done

  if [[ -n ${MATCH:-} ]]; then
    print-success-message
    exit 0
  fi

  MATCH=
  pattern='^#auth\s+sufficient\s+pam_tid.so$'

  pcre_compile $pattern

  for line in $lines; do
    pcre_match $line && true
  done

  if [[ -n $MATCH ]]; then
    local prompt=$(
      printf '%s%s %s' \
        '_input?' \
        'About to enable Touch ID support for `sudo` in `sudo_local`.' \
        'Do you wish to proceed? Press (Y/y) to continue: '
    )

    if ! read -q $prompt; then
      print
      exit 0
    fi

    # We use `[[:blank:]]` here instead of `[[:space:]]` or `\s` because
    # `[[:blank:]]` only matches space and horizontal tab. Also, `\s` doesn't
    # work with `sed` (at least not on macOS).
    pattern='^#auth[[:blank:]]+sufficient[[:blank:]]+pam_tid.so$'

    print
    print-info 'Enabling Touch ID support for `sudo` in `sudo_local`...'
    sed -i '' -E "s/${pattern}/${MATCH:1}/" $sudo_local
    print-success-message
    exit 0
  fi

  print-error 'Could not configure Touch ID support for `sudo`.'
  exit 1
}

main
