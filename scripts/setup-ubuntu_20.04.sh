#!/bin/env bash

sudo apt update &&
    sudo apt upgrade -y &&
    sudo apt remove -y vim &&
    sudo apt install -y tldr neovim mlocate python3-pip powerline screenfetch neofetch &&
    sudo apt autoremove -y &&
    tldr tldr && # pre-download tldr stuff, not necessary but nice.
    pip3 install powerline-status &&
    {
        echo ""
        echo "alias python=python3"
        echo "alias pip=pip3"
        echo ""
        echo "if [ -f \"$(which powerline-daemon)\" ]; then"
        echo "  powerline-daemon -q"
        echo "  POWERLINE_BASH_CONTINUATION=1"
        echo "  POWERLINE_BASH_SELECT=1"
        echo "  . /usr/share/powerline/bindings/bash/powerline.sh"
        echo "fi"
    } >>~/.bashrc &&
    . ~/.bashrc