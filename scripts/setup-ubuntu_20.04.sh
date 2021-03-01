#!/bin/env bash

sudo apt update &&
    sudo apt upgrade -y &&
    sudo apt remove -y vim && # I prefer Neovim :)
    sudo apt install -y \
jq \
mlocate \
neofetch \
neovim \
powerline \
python3 \
python3-pip \
python3-venv \
screenfetch \
tldr &&
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