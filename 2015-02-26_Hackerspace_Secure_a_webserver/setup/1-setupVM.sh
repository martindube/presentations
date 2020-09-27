#!/bin/ksh
# Bash script to setup basic configs of HF 2013 VMs

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root."
    exit
fi

TEXT_COLOR="[38;05;105m"
DEFAULT_COLOR="[38;05;015m"

# Install some packages
echo $TEXT_COLOR''Installing some packages''$DEFAULT_COLOR
./sh/installPackages.sh

# Generate a new SSH Key for the server
echo $TEXT_COLOR''Generating new ssh keys''$DEFAULT_COLOR
/usr/bin/ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
/usr/bin/ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa

# Set authorized_keys
if [ ! -d ~/.ssh ]
then
    echo $TEXT_COLOR''.ssh folder doesn\' exist, creating.''$DEFAULT_COLOR
    /bin/mkdir ~/.ssh
fi
echo $TEXT_COLOR''Setting up authorized_keys''$DEFAULT_COLOR
/bin/cat files/ssh-keys/martin.pub > ~/.ssh/authorized_keys

