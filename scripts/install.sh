#!/bin/bash

set -e
set -x

sudo apt update
sudo apt upgrade

echo "******************"
echo "Installing zsh"
sudo apt install zsh -y
chsh -s $(shell which zsh)
echo "******************"

# Oh My Zsh
REPLACE_RC='no'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt-get install -y $1
  else
    echo "Already installed: ${1}"
  fi
}


# Most of this is from github.com/tjdevries/config_manager
if ! [ -d $HOME/.pyenv ]; then
    curl https://pyenv.run | bash

fi

mkdir -p ~/git
mkdir -p ~/build

# Bunch of useful stuff
sudo apt-get install -y make cmake git xclip
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
sudo apt-get install -y gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

# Install neovim from source
if ! [ -d $HOME/build/neovim ]; then

    pyenv install 3.7.2
    pyenv virtualenv 3.7.2 neovim
    pyenv activate; pip install pynvim; pyenv deactivate

    git clone https://github.com/neovim/neovim ~/git/neovim;
    cd ~/build/neovim/
    make
    sudo make install
fi

# Nice to have
install fzf
install ripgrep
