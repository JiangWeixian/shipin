#!/usr/bin/env bash
source ./ask.test.sh
source ./select.test.sh

IS_INSTALL_BREW=y
ask "install homebrew" IS_INSTALL_BREW
if [ $IS_INSTALL_BREW == y ]; then
  clear
  if ! command -v brew &> /dev/null; then
    printf 'installing homebrew \r'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    printf 'installed homebrew \n'
  else
    printf 'homebrew already installed \n'
  fi
fi