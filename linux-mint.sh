#!/usr/bin/env bash

set -e

# Applications and tools.
sudo apt update

sudo apt install -y git
git config --global user.name 'Edvinas'
git config --global user.email 'edvinas108@gmail.com'

sudo apt install -y fonts-firacode
sudo apt install -y snapd

# Applications managed by snap.
sudo snap install keepassxc
sudo snap install hugo
sudo snap install docker
sudo snap install gimp
sudo snap install discord
sudo snap install postman

sudo snap install intellij-idea-ultimate --classic
sudo snap install clion --classic

# Home dir structure.
mkdir ~/Projects

rm -r ~/Public
rm -r ~/Videos
rm -r ~/Music
rm -r ~/Templates

# Change lock shortcut to Window+L.
gsettings set org.cinnamon.desktop.keybindings.media-keys screensaver \
  "['<Super>l', 'XF86ScreenSaver']"

# Themes.
gsettings set org.cinnamon.desktop.interface icon-theme 'Mint-Y-Dark-Orange'
gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-Y-Dark-Orange'
gsettings set org.cinnamon.desktop.wm.preferences theme 'Mint-Y-Dark'
gsettings set org.cinnamon.theme name 'Mint-Y-Dark-Orange'

# Keyboard layouts.
gsettings set org.gnome.libgnomekbd.keyboard layouts "['us', 'lt']"
gsettings set org.gnome.libgnomekbd.keyboard options \
  "['grp\tgrp:alt_shift_toggle']"

# RedShift.
echo '''
[redshift]
temp-day=4000
temp-night=3000
''' > ~/.config/redshift.conf
