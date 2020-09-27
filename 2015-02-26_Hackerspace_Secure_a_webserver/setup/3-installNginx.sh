#!/bin/ksh

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root."
    exit
fi

pkg_add nginx-1.5.7p3

if [ ! -d /etc/nginx/conf.d ]
then
    mkdir /etc/nginx/conf.d
fi
