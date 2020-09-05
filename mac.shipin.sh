#!/bin/sh

# Request confirm
ask() {
  read -r -n 1 -p "❯ would like $1? y/n: " "$2"
  echo
}
# Renders a text based list of options that can be selected by the
# user using up, down and enter keys and returns the chosen option.
#
# Arguments   : list of options, maximum of 256
# Return value: selected index (0 for opt1, 1 for opt2 ...)
selecteds=()
function select_option() {

  # little helpers for terminal print control and key input
  ESC=$(printf "\033")
  cursor_blink_on() { printf "$ESC[?25h"; }
  cursor_blink_off() { printf "$ESC[?25l"; }
  cursor_to() { printf "$ESC[$1;${2:-1}H"; }
  print_unchecked_option() { printf "  ✗ $1 "; }
  print_selected_unchecked_option() { printf "❯ ✗ $1"; }
  print_selected_checked_option() { printf "❯ ✓ $1"; }
  print_checked_option() { printf "  ✓ $1"; }
  get_cursor_row() {
    IFS=';' read -sdR -p $'\E[6n' ROW COL
    echo ${ROW#*[}
  }
  key_input() {
    read -s -n3 key 2>/dev/null >&2
    if [[ $key = $ESC[A ]]; then echo up; fi
    if [[ $key = $ESC[B ]]; then echo down; fi
    if [[ $key = $ESC[D ]]; then echo left; fi
    if [[ $key = $ESC[C ]]; then echo right; fi
    if [[ $key = "" ]]; then echo enter; fi
  }

  # initially print empty new lines (scroll down if at bottom of screen)
  for opt; do printf "\n"; done

  # determine current screen position for overwriting the options
  local lastrow=$(get_cursor_row)
  local startrow=$(($lastrow - $#))

  # ensure cursor and input echoing back on upon a ctrl+c during read -s
  trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
  cursor_blink_off

  local selected=0
  while true; do
    # print options by overwriting the last lines
    local idx=0
    for opt; do
      cursor_to $(($startrow + $idx))
      if [[ $idx -eq $selected && ! "${selecteds[@]}" =~ "$idx" ]]; then
        print_selected_unchecked_option "$opt"
      elif [[ $idx -eq $selected && "${selecteds[@]}" =~ "$idx" ]]; then
        print_selected_checked_option "$opt"
      elif [[ $idx -ne $selected && ! "${selecteds[@]}" =~ "$idx" ]]; then
        print_unchecked_option "$opt"
      else
        print_checked_option "$opt"
      fi
      ((idx++))
    done

    # user key control
    case $(key_input) in
    enter) break ;;
    right)
      selecteds+=($selected)
      ;;
    left)
      deleted=($selected)
      selecteds=("${selecteds[@]/$deleted}") 
      ;;
    up)
      ((selected--))
      if [ $selected -lt 0 ]; then selected=$(($# - 1)); fi
      ;;
    down)
      ((selected++))
      if [ $selected -ge $# ]; then selected=0; fi
      ;;
    esac
  done

  # cursor position back to normal
  cursor_to $lastrow
  printf "\n"
  cursor_blink_on
}
# git
# https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
IS_INSTALL_GIT=y
IS_CONFIG_GITHUB=y
ask "install git" IS_INSTALL_GIT
ask "config git" IS_CONFIG_GITHUB
if [ $IS_INSTALL_GIT = y ]; then
  if ! command -v git &> /dev/null; then
    printf 'installing git \r'
    git --version
    printf 'installed git \n'
  else
    printf 'git already installed \n'
  fi
fi

# config git
if [ $IS_CONFIG_GITHUB=y ]; then
  if [ $IS_CONFIG_GITHUB = y ]; then
    read -p '❯ github username: ' GITHUB_USERNAME
    read -p '❯ github useremail: ' GITHUB_USEREMAIL
    git config --global user.name $GITHUB_USERNAME
    git config --global user.email $GITHUB_USEREMAIL
    ssh-keygen -t rsa -C "$GITHUB_USEREMAIL"
  fi
fi

# ohmyzsh
# https://github.com/ohmyzsh/ohmyzsh
IS_INSTALL_ZSH=y
ask "install ohmyzsh" IS_INSTALL_ZSH
if [ $IS_INSTALL_ZSH = y ]; then
  if ! command -v zsh &> /dev/null; then
    printf 'installing ohmyzsh \r'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    printf 'installed ohmyzsh \n'
  else
    printf 'ohmyzsh already installed \n'
  fi
fi

# zsh plugins
# install zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install zsh-syntax-highlighting.git
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#in-your-zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# p10k
# https://github.com/romkatv/powerlevel10k#oh-my-zsh
IS_POWER10K=y
ask "boot ohmyzsh with powerlevel10k" IS_POWER10K
if [ $IS_POWER10K = y ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  p10k configure
fi

# enhance keyboard
IS_BIND_ARROWKEY=y
ask "bind arrow key": IS_BIND_ARROWKEY
if [ $IS_BIND_ARROWKEY = y ]; then
  echo "bindkey "\e\e[D" backward-word" >> ${ZDOTDIR:-$HOME}/.zshrc
  echo "bindkey "\e\e[C" forward-word" >> ${ZDOTDIR:-$HOME}/.zshrc
fi

# nvm
# https://github.com/nvm-sh/nvm
IS_INSTALL_NVM=y
ask "install nvm" IS_INSTALL_NVM
if [ $IS_INSTALL_NVM=y ]; then
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


# install homebrew
# https://brew.sh/
IS_INSTALL_BREW=y
ask "install homebrew" IS_INSTALL_BREW
if [ $IS_INSTALL_BREW = y ]; then
  if ! command -v brew &> /dev/null; then
    printf 'installing homebrew \r'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    printf 'installed homebrew \n'
  else
    printf 'homebrew already installed \n'
  fi
fi

# awesome cli tools
selecteds=()
clitools=(npm-trash npm-gh-quick-command npm-tldr brew-unrar brew-grex)
echo "Select one clitool using 「up/down」 keys to browse, 「left/right」 keys to select and enter to confirm:"
echo
select_option "${clitools[@]}"
for idx in "${selecteds[@]}"; do
  if [[ ${clitools[idx]} =~ (npm|brew)-([a-z-]+) ]]; then
    case "${BASH_REMATCH[1]}" in
      "npm")
        npm install "${BASH_REMATCH[2]}" -g
        ;;
      "brew")
        brew install "${BASH_REMATCH[2]}"
        ;;
    esac
  fi
done
printf '\e]8;;https://github.com/JiangWeixian/shipin/blob/master/docs/clitools.md\e\\man-preview of clitools\e]8;;\e\\\n'

# install alfred
IS_INSTALL_ALFRED=y
IS_INSTALL_ALFRED_THEME=y
ask "install alfred" IS_INSTALL_ALFRED
ask "install alfred-simple theme" IS_INSTALL_ALFRED_THEME
if [ $IS_INSTALL_ALFRED = y ]; then
  printf 'installing alfred \r'
  brew cask install alfred
  printf 'installed alfred \n'
fi

# use alfred-simple theme
# https://github.com/sindresorhus/alfred-simple
if [ $IS_INSTALL_ALFRED_THEME = y ]; then
  printf 'installing alfred simple theme \r'
  brew tap danielbayley/alfred
  brew cask install alfred-theme-simple
  printf 'installed alfred simple theme \r'
fi

selecteds=()
apps=(wechat iterm2 qq charles notion google-chrome visual-studio-code enpass switchhosts slack kap sequel-pro)
echo "Select one clitool using 「up/down」 keys to browse, 「left/right」 keys to select and enter to confirm:"
echo
select_option "${apps[@]}"
for idx in ${selecteds[@]}; do
  printf 'installing %s \r' ${app[idx]}
  brew cask install $app
done

