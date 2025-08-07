#!/usr/bin/env sh

if [ "$(uname)" = 'Linux' ] && [ "$(basename "${SHELL}")" != 'zsh' ]; then
  sudo apt install --assume-yes curl git zsh
  chsh -s "$(which zsh)"
  printf 'Restart and re-run this script to continue.\n'
  exit
fi

if [ "$(uname)" = 'Linux' ] && [ "$(basename "${SHELL}")" = 'zsh' ]; then
  sudo apt install --assume-yes jq rsync vim
fi
