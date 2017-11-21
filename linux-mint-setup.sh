#!/usr/bin/env bash

# Update all repositories.
sudo apt-get update
sudo apt-get upgrade -y


#
# Convienience tools.
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
mkdir ~/Documents/Projects


#
# Dev tools.
#

# Version control.
sudo apt-get install -y git
git config --global user.name 'Edvinas'
git config --global user.email 'evinas108@gmail.com'

# Hack to enable silent Java installation.
echo debconf shared/accepted-oracle-license-v1-1 select true |\
sudo debconf-set-selections

echo debconf shared/accepted-oracle-license-v1-1 seen true |\
sudo debconf-set-selections

# Install Java 8 and set it as default.
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer
sudo apt-get install -y install oracle-java8-set-default

echo 'JAVA_HOME="/usr/lib/jvm/java-8-oracle/jre/bin/java"' |\
sudo tee -a /etc/environment

# VirtualBox for setting up virtual machines.
sudo apt-get install -y virtualbox
mkdir ~/Documents/VMs
vboxmanage setproperty machinefolder ~/Documents/VMs

# Useful VirtualBox setup tool.
sudo apt-get install -y vagrant
