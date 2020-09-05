#!/usr/bin/env bash
source ./ask.test.sh

IS_INSTALL_NVM=y
ask "install nvm" IS_INSTALL_NVM
if [ $IS_INSTALL_NVM == y ]; then
  clear
  if ! command -v nvm &> /dev/null; then
    printf 'installing nvm \r'
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | sh
    printf 'installed nvm \n'
    echo "export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion" >> ${ZDOTDIR:-$HOME}/.zshrc

    # install lts nodejs
    nvm install --lts
  else
    printf 'nvm already installed \n'
  fi
fi
IS_INSTALL_LTS_NODEJS=y
ask "install lts nodejs" IS_INSTALL_LTS_NODEJS
if [ $IS_INSTALL_LTS_NODEJS == y ]; then
  clear
  source ~/.nvm/nvm.sh
  # install lts nodejs
  nvm install --lts
fi