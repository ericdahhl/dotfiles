# Installation script. Should work for ubuntu and MAC OS.
# Installs Brew, Zsh and some other stuff.
# Assumes the .zshrc from this repo has been cloned

TOOLS=(tmux neovim ripgrep fzf pyenv)

install_brew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew update
}

brew_install_tools() {
    for tool in ${TOOLS[@]}; do
        brew install $tool
    done
}

install_oh_my_zsh() {
    if ! [ -d $HOME/.oh-my-zsh ]; then
        export KEEP_ZSHRC='yes'
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
}

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Ubuntu/Debian
    sudo apt update
    sudo apt upgrade

    sudo apt-get install build-essential procps curl file git

    if ! [ -n "$ZSH_VERSION" ]; then
        echo "Installing zsh"
        sudo apt install zsh -y
        chsh -s $(which zsh)
    fi

    install_oh_my_zsh
    install_brew
    brew_install_tools


elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    xcode-select --install
    install_brew
    install_oh_my_zsh
    install_tools
else
    echo "The OS is not supported by this script, so much for being OS agnostic..."
    exit 1
fi
