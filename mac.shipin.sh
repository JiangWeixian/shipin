#!/bin/sh

# git
# https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
if ! command -v git &> /dev/null; then
  printf 'installing git \r'
  git --version
  printf 'installed git \n'
else
  printf 'git already installed \n'
fi

# config git
read -p 'github username: ' GITHUB_USERNAME
read -p 'github useremail: ' GITHUB_USEREMAIL
git config --global user.name $GITHUB_USERNAME
git config --global user.email $GITHUB_USEREMAIL
ssh-keygen -t rsa -C "$GITHUB_USEREMAIL"

# ohmyzsh
# https://github.com/ohmyzsh/ohmyzsh
if ! command -v zsh &> /dev/null; then
  printf 'installing ohmyzsh \r'
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  printf 'installed ohmyzsh \n'
else
  printf 'ohmyzsh already installed \n'
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
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
p10k configure

# enhance keyboard
echo "bindkey "\e\e[D" backward-word" >> ${ZDOTDIR:-$HOME}/.zshrc
echo "bindkey "\e\e[C" forward-word" >> ${ZDOTDIR:-$HOME}/.zshrc

# nvm
# https://github.com/nvm-sh/nvm
if ! command -v nvm &> /dev/null; then
  printf 'installing nvm \r'
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | sh
  printf 'installed nvm \n'
else
  printf 'nvm already installed \n'
fi

echo "export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion" >> ${ZDOTDIR:-$HOME}/.zshrc

# install lts nodejs
nvm install --lts

# install homebrew
# https://brew.sh/
if ! command -v brew &> /dev/null; then
  printf 'installing homebrew \r'
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  printf 'installed homebrew \n'
else
  printf 'homebrew already installed \n'
fi

# awesome cli tools
# trash
# https://github.com/sindresorhus/trash
npm install trash -g

# gh-quick-command
# https://github.com/JiangWeixian/gh-quick-command
npm install gh-quick-command -g

# tldr
# https://github.com/tldr-pages/tldr
npm install tldr -g

# unrar
brew install unrar

# grex
# https://github.com/pemistahl/grex
brew install grex

# install alfred
printf 'installing alfred \r'
brew cask install alfred
printf 'installed alfred \n'

# use alfred-simple theme
# https://github.com/sindresorhus/alfred-simple
printf 'installing alfred simple theme \r'
brew tap danielbayley/alfred
brew cask install alfred-theme-simple
printf 'installed alfred simple theme \r'

# config alfred workflows
curl -s  https://raw.githubusercontent.com/TheColdVoid/nbnhhsh/master/nbnhhsh.alfredworkflow -o nbnhhsh.alfredworkflow
open nbnhhsh.alfredworkflow

apps=(wechat iterm2 qq charles notion google-chrome visual-studio-code enpass switchhosts slack kap)
for app in ${apps[@]}; do
  printf 'installing %s \r' ${app}
  brew cask install $app
  printf 'installed %s \n' ${app}
done

