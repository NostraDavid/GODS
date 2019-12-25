#!/bin/sh
# Execute like ./setup-zsh.sh
# used colors
green="\033[0;32m"
red="\033[0;31m"
white="\033[0;37m"
cyan="\033[0;36m"

main () {
    echo $green"Did you run an initial$red sudo apt update && sudo apt upgrade -y$green before running this script?"
    
    while true; do
        read -p "[Y/n]: " yn
        case $yn in
            [Yy]* ) yes;;
            [Nn]* ) no;;
            * ) echo "Please answer y or n.";;
        esac
    done
}

yes () {
    install_programs
    # copy my custom zshrc
    cp ../data/.zshrc ~/
    break
}

no () {
    exit
}

install_programs() {
    echo $cyan"Installing essentials"
    # Install Oh-My-Zsh
    sudo apt install zsh -y
    sudo apt install curl -y
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

main