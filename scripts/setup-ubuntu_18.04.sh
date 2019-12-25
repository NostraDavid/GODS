#!/bin/sh
# Execute like ./setup-ubuntu_18.04.sh
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
            * ) echo "Please answer yes or no.";;
        esac
    done
}

yes () {
    remove_programs
    install_programs
    break
}

no () {
    exit
}

remove_programs () {
    echo $cyan"Removing bullshit"
    sudo apt remove vim -y
    sudo apt remove bash -y
    sudo apt autoremove -y
}

install_programs() {
    echo $cyan"Installing essentials"
    # Neovim because vim sucks ass.
    sudo apt install neovim -y
    # browsh so I can browse in the shell, with Firefox as backend
    sudo apt install firefox -y
    sudo apt install browsh -y
    # hyperfine for benchmarking
    sudo apt install hyperfine -y
    # tldr because man sucks ass
    sudo apt install tldr -y
    # fetching programs (I haven't decided yet which one I want to keep 2019-12-08)
    sudo apt install screenfetch neofetch -y
    # ZSH related stuff
    sudo apt install autojump fortune cowsay python-pygments command-not-found zeal fasd httpie ripgrep taskwarrior python3-dev python3-pip python3-setuptools -y
    # type 'fuck' as both a curse and to fix the last command
    sudo pip3 install thefuck -y
}

main