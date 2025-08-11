#!/usr/bin/env sh

has_command() {
  command -v "${1}" >/dev/null 2>&1
}

if [ "$(uname)" = 'Linux' ] && [ "$(basename "${SHELL}")" != 'zsh' ]; then
  sudo apt install --assume-yes build-essential curl git zsh
  chsh -s "$(which zsh)"
  printf 'Restart the system and re-run this script to continue.\n'
  exit
fi

if [ "$(uname)" = 'Linux' ] && [ "$(basename "${SHELL}")" = 'zsh' ]; then
  sudo apt install --assume-yes jq rsync vim
fi
