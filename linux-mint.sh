#!/usr/bin/env bash

set -e

sudo apt update

# Git.
sudo apt install -y git
git config --global user.name 'Edvinas'
git config --global user.email 'edvinas108@gmail.com'

# Power saving.
sudo apt install -y tlp tlp-rdw
sudo tlp start

# Fonts.
sudo apt install -y fonts-firacode

# Snap.
sudo apt install -y snapd

# General applications.
sudo snap install keepassxc
sudo snap install gimp
sudo snap install discord

# Dev tools.
sudo snap install postman
sudo snap install hugo
sudo snap install docker

# C# programming tools.
sudo snap install dotnet-sdk --classic
sudo snap install dotnet-runtime-31
sudo ln -s /snap/dotnet-sdk/current/dotnet /usr/local/bin/dotnet

# IDEs.
sudo snap install intellij-idea-ultimate --classic
sudo snap install rider --classic
sudo snap install clion --classic

# Visual Studio Code.
sudo snap install code --classic

code --install-extension streetsidesoftware.code-spell-checker
code --install-extension editorconfig.editorconfig
code --install-extension equinusocio.vsc-material-theme
code --install-extension pkief.material-icon-theme

echo '''
{
  "editor.fontSize": 16,
  "editor.fontFamily": "Fira Code",
  "editor.fontLigatures": true,
  "editor.minimap.enabled": false,
  "editor.rulers": [80, 100],
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "editor.detectIndentation": false,
  "editor.wordWrap": "on",
  "workbench.colorTheme": "Material Theme",
  "workbench.iconTheme": "material-icon-theme"
}
''' > ~/.config/Code/User/settings.json

# Unity (Actual installation happens via UnityHub).
mkdir -p ~/Software/Unity

wget https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage \
  -O ~/Software/Unity/UnityHub.AppImage

chmod u+x ~/Software/Unity/UnityHub.AppImage

sudo apt install libgconf-2-4

# Home dir structure.
mkdir -p ~/Projects
mkdir -p ~/Software

rm -rf ~/Public
rm -rf ~/Videos
rm -rf ~/Music
rm -rf ~/Templates

# Change lock shortcut to Super+L.
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

# Firewall.
sudo ufw enable

# Set DNS to Cloudflare.
echo '''
supersede domain-name-servers 1.1.1.1, 1.0.0.1;
supersede dhcp6.name-servers 2606:4700:4700::1111, 2606:4700:4700::1001;
''' | sudo tee -a /etc/dhcp/dhclient.conf

# Fix clock when dual-booting.
timedatectl set-local-rtc 1 --adjust-system-clock
