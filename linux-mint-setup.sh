#!/usr/bin/env bash

#
# Initial update for all repositories.
#
sudo apt-get update
sudo apt-get upgrade -y


#
# Specific versions for some dependencies.
#

# Vagrant VM setup tool version.
VAGRANT_VERSION='2.0.2'

# Chef development kit version.
CHEF_DK_VERSION='2.4.17'

# Slack version.
SLACK_VERSION='3.0.5'


#
# Convenience tools.
#

# Make sure that latest firefox is installed.
sudo apt-add-repository -y ppa:mozillateam/firefox-next
sudo apt-get update 
sudo apt-get install --reinstall firefox

# Sometimes a different browser is required.
sudo apt-get install -y chromium-browser

# Nice text editor.
sudo apt-get install -y gedit

# Something nice for the eyes.
sudo apt-get install -y redshift-gtk
echo '''
[redshift]
temp-day=5000
temp-night=3000
''' > ~/.config/redshift.conf

# Password manager.
sudo apt-get install -y keepassx

# Screen capture tool.
sudo apt-get install -y shutter
sudo apt-get install -y libgoo-canvas-perl

# Cloud storage.
sudo apt-get install -y dropbox

# Handy collaboration / chat software.
url=https://downloads.slack-edge.com/linux_releases
url+="/slack-desktop-${SLACK_VERSION}-amd64.deb"
wget ${url}

sudo apt-get install -y libcurl3
sudo dpkg -i slack-desktop-${SLACK_VERSION}-amd64.deb

rm slack-desktop-${SLACK_VERSION}-amd64.deb


#
# Directories, look and feel.
#

# Common project dir.
mkdir ~/Documents/Projects

# Unused directories.
rm -r ~/Templates
rm -r ~/Videos
rm -r ~/Public
rm -r ~/Music

# Lock screen shortcut.
gsettings set org.cinnamon.desktop.keybindings.media-keys screensaver \
    "['<Super>l', 'XF86ScreenSaver']"

# Icon colors.
gsettings set org.cinnamon.desktop.interface icon-theme 'Mint-X-Orange'

# Interface / hilight colors.
gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-X-Orange'

# Pretty monospace font.
url="https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode"
mkdir -p ~/.local/share/fonts
for type in Bold Light Medium Regular Retina; do
    wget -O ~/.local/share/fonts/FiraCode-${type}.ttf \
        "${url}-${type}.ttf?raw=true";
done

fc-cache -f

# Set keyboard layouts.
gsettings set org.gnome.libgnomekbd.keyboard layouts "['us', 'lt']"

# Set shortcut for switching to another layout.
gsettings set org.gnome.libgnomekbd.keyboard options "['grp\tgrp:alt_shift_toggle']"


#
# Dev tools.
#

# Version control.
sudo apt-get install -y git
git config --global user.name 'Edvinas'
git config --global user.email 'edvinas108@gmail.com'

# Hack to enable silent Java installation.
echo oracle-java10-installer shared/accepted-oracle-license-v1-1 select true | \
    sudo /usr/bin/debconf-set-selections

# Install Java 10 and set it as default.
sudo add-apt-repository -y ppa:linuxuprising/java
sudo apt-get update
sudo apt-get install -y oracle-java10-installer
sudo apt-get install -y oracle-java10-set-default

echo 'JAVA_HOME="/usr/lib/jvm/java-10-oracle"' | \
    sudo tee -a /etc/environment

# Setup best IDE for Java (automatically grep latest version).
ideaVersion=$(
    curl https://www.jetbrains.com/updates/updates.xml |\
    grep 'IDEA_Release' -1 |\
    grep -oP 'version="\K[^"]+'
    grep -v 'EDU'
)

wget -O idea.tar.gz \
    "https://download.jetbrains.com/idea/ideaIU-$ideaVersion.tar.gz"

sudo mkdir /opt/idea
sudo tar xf idea.tar.gz --strip 1 -C /opt/idea
sudo ln -s /opt/idea/bin/idea.sh /usr/local/bin/idea

rm idea.tar.gz

# VirtualBox for setting up virtual machines.
sudo apt-get install -y virtualbox
mkdir ~/Documents/VMs
vboxmanage setproperty machinefolder ~/Documents/VMs

# Setup chefdk.
url=https://packages.chef.io/files/stable/chefdk
url+=/${CHEF_DK_VERSION}/debian/8/chefdk_${CHEF_DK_VERSION}-1_amd64.deb
wget ${url}

sudo dpkg -i chefdk_${CHEF_DK_VERSION}-1_amd64.deb

rm chefdk_${CHEF_DK_VERSION}-1_amd64.deb

# Useful VirtualBox setup tool.
url=https://releases.hashicorp.com/vagrant
url+="/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_x86_64.deb"
wget ${url}

sudo dpkg -i "vagrant_${VAGRANT_VERSION}_x86_64.deb"
vagrant plugin install vagrant-berkshelf

rm vagrant_${VAGRANT_VERSION}_x86_64.deb

# REST API testing tool.
wget -O postman.tar.gz https://dl.pstmn.io/download/latest/linux64

sudo mkdir /opt/postman
sudo tar xf postman.tar.gz --strip 1 -C /opt/postman
sudo ln -s /opt/postman/Postman /usr/local/bin/postman

rm postman.tar.gz

# Packet sniffing / viewing tool, install silently.
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install wireshark
echo "wireshark-common wireshark-common/install-setuid boolean true" | \
    sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure wireshark-common
sudo usermod -a -G wireshark $USER
newgrp wireshark

# JavaScript development tools.
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
