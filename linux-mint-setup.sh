#!/usr/bin/env bash

# Update all repositories.
sudo apt-get update
sudo apt-get upgrade -y


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

# Password manager.
sudo apt-get install -y keepassx

# Screen capture tool.
sudo apt-get install -y shutter
sudo apt-get install -y libgoo-canvas-perl

# Cloud storage.
sudo apt-get install -y dropbox

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

# Pretty monospace font.
url="https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode"
mkdir -p ~/.local/share/fonts
for type in Bold Light Medium Regular Retina; do
    wget -O ~/.local/share/fonts/FiraCode-${type}.ttf \
    "${url}-${type}.ttf?raw=true";
done

fc-cache -f

#
# Dev tools.
#

# Version control.
sudo apt-get install -y git
git config --global user.name 'Edvinas'
git config --global user.email 'evinas108@gmail.com'

# Hack to enable silent Java installation.
echo debconf shared/accepted-oracle-license-v1-1 select true | \
    sudo debconf-set-selections

echo debconf shared/accepted-oracle-license-v1-1 seen true | \
    sudo debconf-set-selections

# Install Java 8 and set it as default.
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer
sudo apt-get install -y install oracle-java8-set-default

echo 'JAVA_HOME="/usr/lib/jvm/java-8-oracle/jre/bin/java"' | \
    sudo tee -a /etc/environment

# Setup best IDE for Java (automatically grep latest version).
ideaVersion=$(
    curl https://www.jetbrains.com/updates/updates.xml |\
    grep 'IDEA_Release' -1 |\
    grep -oP 'version="\K[^"]+'
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
url+=/2.3.4/debian/8/chefdk_2.3.4-1_amd64.deb
wget ${url}

sudo dpkg -i chefdk_2.3.4-1_amd64.deb
rm chefdk_2.3.4-1_amd64.deb

# Useful VirtualBox setup tool.
wget https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.deb
sudo dpkg -i vagrant_2.0.1_x86_64.deb
rm vagrant_2.0.1_x86_64.deb

vagrant plugin install vagrant-berkshelf

# REST API testing tool.
wget -O postman.tar.gz https://dl.pstmn.io/download/latest/linux64

sudo mkdir /opt/postman
sudo tar xf postman.tar.gz --strip 1 -C /opt/postman
sudo ln -s /opt/postman/Postman /usr/local/bin/postman

rm postman.tar.gz