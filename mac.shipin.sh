#!/bin/sh

# install git
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

# install ohmyzsh
# https://github.com/ohmyzsh/ohmyzsh
if ! command -v zsh &> /dev/null; then
  printf 'installing ohmyzsh \r'
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  printf 'installed ohmyzsh \n'
else
  printf 'ohmyzsh already installed \n'
fi

# config zsh plugins

# config zsh with pk10

# install nvm
if ! command -v nvm &> /dev/null; then
  printf 'installing nvm \r'
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | sh
  printf 'installed nvm \n'
else
  printf 'nvm already installed \n'
fi

# install lts nodejs


# install homebrew
# https://brew.sh/
if ! command -v brew &> /dev/null; then
  printf 'installing homebrew \r'
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  printf 'installed homebrew \n'
else
  printf 'homebrew already installed \n'
fi

# install alfred
printf 'installing alfred \r'
brew cask install alfred
printf 'installed alfred \n'

# config alfred workflows

apps=(wechat iterm2 qq charles notion google-chrome visual-studio-code enpass trojan-qt5 switchhosts slack)
for app in ${apps[@]}; do
  printf 'installing %s \r' ${app}
  brew cask install $app
  printf 'installed %s \n' ${app}
done

