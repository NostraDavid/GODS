# change default password
passwd

# remove pythons
sudo apt remove python
sudo apt autoremove

# make sure git is installed though it probably is
sudo apt install git

mkdir Programming && cd Programming/

cd ~/.ssh && ssh-keygen
# copy the output of `id_rsa.pub` to https://github.com/settings/keys
cat id_rsa.pub
# move back to where you were
cd -

# set needed git config
git config --global user.name "NostraDavid"
git config --global user.email "NostraDavid@outlook.com"

git clone git@github.com:NostraDavid/GODS.git

sudo apt update &&
    sudo apt upgrade -y &&
    sudo apt remove -y vim && # I prefer Neovim :)
    sudo apt install -y \
mlocate \
neofetch \
neovim \
tldr

# pypy 32 bit isn't available for RPI ;_;

# set Python3 as default
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10
