#!/bin/bash

# This needs some work...

set -e
set -x

sudo apt update
sudo apt upgrade

if ! [ -n "$ZSH_VERSION" ]; then
	echo "Installing zsh"
	sudo apt install zsh -y
	chsh -s $(which zsh)
fi

# Oh My Zsh
if ! [ -d $HOME/.oh-my-zsh ]; then
	export KEEP_ZSHRC='yes' # Since .zshrc is cloned from git
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt-get install -y $1
  else
    echo "Already installed: ${1}"
  fi
}

# Nice to have
install fzf
install ripgrep

# Most of this is from github.com/tjdevries/config_manager
if ! [ -d $HOME/.pyenv ]; then
    curl https://pyenv.run | bash
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
fi


# Bunch of useful stuff
sudo apt-get install -y make cmake git xclip
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
sudo apt-get install -y gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

mkdir -p ~/build

# Install neovim from source
if ! [ -d $HOME/build/neovim ]; then

    pyenv install 3.7.2
    pyenv virtualenv 3.7.2 neovim
    pyenv activate neovim; pip install pynvim; pyenv deactivate

    git clone https://github.com/neovim/neovim ~/build/neovim;

    cd ~/build/neovim/
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
fi

# Vim-plug
echo 'INSTALLING VIMPLUG FOR NEOVIM'
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo 'VIMPLUG INSTALLED'
