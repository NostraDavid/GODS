#!/bin/env bash

# don't forget to download, install and use (set font in the terminal) the powerline fonts:
# https://github.com/powerline/fonts

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
        echo ""
        echo "bind 'set completion-ignore-case on'"
        echo ""
        # Source: https://www.computerhope.com/unix/bash/shopt.htm#bash-options
        echo "shopt -s autocd"
        echo "shopt -s cdspell"
        echo "shopt -s dirspell"
    } >>~/.bashrc &&
    . ~/.bashrc &&
    mkdir -p ~/.config/powerline &&
    cp -r /usr/share/powerline/config_files/* ~/.config/powerline &&
    jq 'del(.segments.left[] | select(.function == "powerline.segments.common.env.user")) | {segments:{left:[(.segments.left[] | select(.function == "powerline.segments.shell.cwd") += {"args":{"dir_shorten_len": 2}})]}}' ~/.config/powerline/themes/shell/default_leftonly.json > ~/.config/powerline/themes/shell/temp.json &&
    rm ~/.config/powerline/themes/shell/default_leftonly.json &&
    mv ~/.config/powerline/themes/shell/temp.json ~/.config/powerline/themes/shell/default_leftonly.json &&
    powerline-daemon --replace
