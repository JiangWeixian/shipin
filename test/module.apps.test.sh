#!/usr/bin/env bash
source ./ask.test.sh
source ./select.test.sh

IS_INSTALL_AWESOME_APPS=y
if [ $IS_INSTALL_AWESOME_APPS == y ]; then
  clear
  selecteds=()
  apps=(wechat iterm2 qq charles notion google-chrome visual-studio-code enpass switchhosts slack kap sequel-pro)
  echo "- Select apps using 「up/down」 keys to browse, 「left/right」 keys to select and 「enter」 to confirm:"
  echo
  select_option "${apps[@]}"
  for idx in ${selecteds[@]}; do
    echo "installing ${apps[idx]}"
    brew cask install ${apps[idx]}
  done
fi