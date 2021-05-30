# Make sure to set

# change default password
passwd

# make sure git is installed though it probably is
sudo apt install git

mkdir ~/Programming

cd ~/.ssh && ssh-keygen

# copy the output of `id_rsa.pub` to https://github.com/settings/keys
cat id_rsa.pub
# move back to where you were
cd -

# set needed git config
git config --global user.name "NostraDavid"
git config --global user.email "NostraDavid@outlook.com"

git clone git@github.com:NostraDavid/GODS.git

sudo apt-get update &&
    sudo apt-get upgrade -y &&
    sudo apt-get dist-upgrade &&
    sudo apt remove -y vim && # I prefer Neovim :)
    sudo apt install -y \
        fonts-powerline \
        hyperfine \
        jq \
        mlocate \
        neofetch \
        neovim \
        python3 \
        python3-pip \
        python3-setuptools \
        python3-venv \
        sysbench \
        tldr \
        htop \
        ncdu

# pypy 32 bit isn't available for RPI ;_;

# set Python3 as default
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10

wget https://github.com/sharkdp/hyperfine/releases/download/v1.11.0/hyperfine_1.11.0_armhf.deb
sudo dpkg -i hyperfine_1.11.0_armhf.deb
"terminal.integrated.fontFamily": "\"DejaVu Sans Mono for Powerline\""

# powerline-status, because powerline was already taken
pip install powerline-status

{
    echo ""
    echo "alias python=python3"
    echo "alias pip=pip3"
    echo ""
    echo "if [ -f \"$(which powerline-daemon)\" ]; then"
    echo "  powerline-daemon -q"
    echo "  POWERLINE_BASH_CONTINUATION=1"
    echo "  POWERLINE_BASH_SELECT=1"
    echo "  . ~/.local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh"
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
    mkdir -p ~/.local/lib/python3.7/site-packages/powerline/ &&
    cp -r ~/.local/lib/python3.7/site-packages/powerline/config_files/* ~/.config/powerline &&
    jq 'del(.segments.left[] | select(.function == "powerline.segments.common.env.user")) | {segments:{left:[(.segments.left[] | select(.function == "powerline.segments.shell.cwd") += {"args":{"dir_shorten_len": 2}})]}}' ~/.config/powerline/themes/shell/default_leftonly.json >~/.config/powerline/themes/shell/temp.json &&
    rm ~/.config/powerline/themes/shell/default_leftonly.json &&
    mv ~/.config/powerline/themes/shell/temp.json ~/.config/powerline/themes/shell/default_leftonly.json &&
    powerline-daemon --replace
