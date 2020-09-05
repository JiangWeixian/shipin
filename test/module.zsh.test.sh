#!/usr/bin/env bash
source ./ask.test.sh
source ./select.test.sh

IS_INSTALL_ZSH=y
clear
ask "install ohmyzsh" IS_INSTALL_ZSH
if [ $IS_INSTALL_ZSH == y ]; then
  if ! command -v zsh &> /dev/null; then
    printf 'installing ohmyzsh \r'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    printf 'installed ohmyzsh \n'
  else
    printf 'ohmyzsh already installed \n'
  fi
  clear
fi

IS_POWER10K=y
ask "bootstrap ohmyzsh with powerlevel10k" IS_POWER10K
if [ $IS_POWER10K == y ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  echo "- Please ZSH_THEME="powerlevel10k/powerlevel10k" in ~/.zshrc"
  echo
fi

plugins=(
  git
  z
  zsh-autosuggestions
  history
  sudo
  copyfile
  copydir
  git-extras
  common-aliases
  zsh-syntax-highlighting
  osx
)
IS_CONFIG_ZSH_PLGUINS=y
ask "config zsh plugins" IS_CONFIG_ZSH_PLGUINS
if [ $IS_CONFIG_ZSH_PLGUINS == y ]; then
  selecteds=()
  selected_plugins=()
  printf '%s Please Check this files about \e]8;;https://github.com/JiangWeixian/shipin/blob/master/docs/zshplugins.md\e\\details of zsh plugins\e]8;;\e\\\n' -
  echo "- Select zsh plugins using 「up/down」 keys to browse, 「left/right」 keys to select and 「enter」 to confirm:"
  echo
  select_option "${plugins[@]}"
  for idx in ${selecteds[@]}; do
    selected_plugins+=(${plugins[idx]})
    case "${plugins[idx]}" in
      "zsh-autosuggestions")
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
      ;;
      "zsh-syntax-highlighting")
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
      ;;
    esac
  done
  echo "- Please copy below code and config to ~/.zshrc"
  echo
  echo "plugin=("
  printf "  %s \n" "${selected_plugins[@]}"
  echo ")"
fi