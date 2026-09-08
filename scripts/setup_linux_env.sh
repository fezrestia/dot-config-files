#!/usr/bin/sh

sudo apt update

sudo apt upgrade

# common
sudo apt install -y \
    curl \
    ssh \
    sshfs \
    htop \
    git \
    git-lfs \
    gitk \
    vim \
    zsh \
    tmux \
    samba \
    parted \


# program lang
sudo apt instal -y \
    ruby-full \


# for ubuntu 24.04
sudo apt install -y \
    vino \
    gnome-tweaks \
    ibus-mozc \


# additional tools
sudo apt install -y \
    sqlitebrowser \
    lm-sensors \



# install local .deb
#
# sudo dpkg -i xxx.deb
#   or
# sudo apt --fix-broken install xxx.deb
#
# chrome
# synergy



