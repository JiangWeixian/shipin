#!/usr/bin/env bash
source ./ask.test.sh

IS_INSTALL_GIT=y
IS_CONFIG_GITHUB=y
clear
ask "install git" IS_INSTALL_GIT
if [ $IS_INSTALL_GIT == y ]; then
  if ! command -v git &> /dev/null; then
    printf 'installing git \r'
    git --version
    printf 'installed git \n'
  else
    printf 'git already installed \n'
  fi
fi

# config git
ask "config git" IS_CONFIG_GITHUB
if [ $IS_CONFIG_GITHUB == y ]; then
  clear
  read -p '❯ Please github username: ' GITHUB_USERNAME
  read -p '❯ Please github useremail: ' GITHUB_USEREMAIL
fi

if [ $IS_CONFIG_GITHUB == y ]; then
  git config --global user.name $GITHUB_USERNAME
  git config --global user.email $GITHUB_USEREMAIL
  ssh-keygen -t rsa -C "$GITHUB_USEREMAIL"
fi
