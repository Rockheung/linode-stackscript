#!/bin/bash
# This block defines the variables the user of the script needs to input
# when deploying using this script.
#
# Set sudo user name
USERNAME=rockheung
#
#tUDF name="hostname" label="The hostname for the new Linode.">
HOSTNAME=sundrycodes
#
#<UDF name="fqdn" label="The new Linode's Fully Qualified Domain Name">
#FQDN=rockheung.xyz

# This sets the variable $IPADDR to the IP address the new Linode receives.
#IPADDR=$(/sbin/ifconfig eth0 | awk '/inet / { print $2 }' | sed 's/addr://')

# This updates the packages on the system from the distribution repositories.
apt update
apt upgrade -y

# This section sets the hostname.
echo $HOSTNAME > /etc/hostname
hostname -F /etc/hostname

# This section sets the Fully Qualified Domain Name (FQDN) in the hosts file.
#echo $IPADDR $FQDN $HOSTNAME >> /etc/hosts

# Add sudo user
adduser --disabled-password --gecos "" $USERNAME
usermod -aG sudo $USERNAME
echo 'add user finished'

# Install Vim-Bootstrap
apt install -y git exuberant-ctags ncurses-term curl vim
sudo -u $USERNAME -H sh -c "/usr/bin/curl 'http://vim-bootstrap.com/generate.vim' --data 'langs=javascript&langs=php&langs=html&langs=ruby&langs=go&langs=c&langs=python&langs=elm&langs=&editor=vim' > ~/.vimrc"
sudo -u $USERNAME -H sh -c "echo -ne '\n' | vim +PlugInstall +qall"
echo 'vim install finished'

# Python virtualenvwrapper
apt install -y python3-pip
sudo -u $USERNAME -H sh -c "/usr/bin/pip3 install -U pip"
sudo -u $USERNAME -H sh -c "pip install virtualenvwrapper"
sudo -u $USERNAME -H sh -c "echo 'export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source $HOME/.local/bin/virtualenvwrapper.sh' >> ~/.bashrc"
echo 'pip install finished'

