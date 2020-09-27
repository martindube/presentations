#!/bin/ksh
# Bash script to customize HF 2014 VMs

TEXT_COLOR="[38;05;105m"
DEFAULT_COLOR="[38;05;015m"

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root."
    exit
fi

usage()
{
    echo "Customize a HF 2014 OpenBSD VM"
    echo " "
    echo "$0 -h HOST -d DOMAIN -i IP -n NETMASK -g GATEWAY"
    echo " "
    echo "options:"
    echo "--help                    show brief help"
    echo "-h, --hostname=HOSTNAME   Hostname of the VM (ex: nagios, irc, banane)"
    echo "-d, --domain=DOMAIN       Domain name of the VM (ex: hf, ctf.hf, etc.)"
    echo "-i, --ip=IP               IP Address of em0 (ex: 172.16.66.X, 1.3.3.X, etc.)"
    echo "-n, --netmask=NETMASK     Netmask of em0 (ex: 255.255.255.0, 255.255.255.240)"
    echo "-g, --gateway=GATEWAY     Gateway of em0 (ex: 172.16.66.1, 1.3.3.1, etc.)"
    echo ""
}

containsElement () {
  local e
  for e in "${@}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

# Menu, arguments, help
while test $# -gt 0; do
        case "$1" in
                --help)
			usage
                        exit 0
                        ;;
                -h)
                        shift
                        if test $# -gt 0; then
                                export HOST=$1
                        else
                                echo "no hostname specified"
                                exit 1
                        fi
                        shift
                        ;;
                --hostname*)
                        export HOST=`echo $1 | sed -e 's/^[^=]*=//g'`
                        shift
                        ;;
                -d)
                        shift
                        if test $# -gt 0; then
                                export DOMAIN=$1
                        else
                                echo "no domain specified"
                                exit 1
                        fi
                        shift
                        ;;
                --domain*)
                        export DOMAIN=`echo $1 | sed -e 's/^[^=]*=//g'`
                        shift
                        ;;
                -i)
                        shift
                        if test $# -gt 0; then
                                export IP=$1
                        else
                                echo "no ip address specified"
                                exit 1
                        fi
                        shift
                        ;;
                --ip*)
                        export IP=`echo $1 | sed -e 's/^[^=]*=//g'`
                        shift
                        ;;
                -n)
                        shift
                        if test $# -gt 0; then
                                export NETMASK=$1
                        else
                                echo "no netmask specified"
                                exit 1
                        fi
                        shift
                        ;;
                --netmask*)
                        export NETMASK=`echo $1 | sed -e 's/^[^=]*=//g'`
                        shift
                        ;;
                -g)
                        shift
                        if test $# -gt 0; then
                                export GATEWAY=$1
                        else
                                echo "no gateway specified"
                                exit 1
                        fi
                        shift
                        ;;
                --gateway*)
                        export GATEWAY=`echo $1 | sed -e 's/^[^=]*=//g'`
                        shift
                        ;;
                *)
                        #if test $# -gt 0; then
                        #        export OUT_FILE=$1
                        #else
                        #        echo "no file specified"
                        #        exit 1
                        #fi
                        break
                        ;;
        esac
done

# Some validations
if [ -z $HOST ] || [ -z $DOMAIN ] || [ -z $IP ] || [ -z $NETMASK ] || [ -z $GATEWAY ] 
then
	usage
	echo There are missing arguments
	exit 1
fi

# Configure /etc/hostname 
echo $TEXT_COLOR''Setting up /etc/hostname''$DEFAULT_COLOR
echo $HOST > /etc/myname
hostname $HOST

# Configure MOTD
echo $TEXT_COLOR''Setting up /etc/motd''$DEFAULT_COLOR
./sh/genMotdHeader.sh -t "obsdhs" files/motd/$HOST.motd
echo 'this string will be overwritten at reboot' >  /etc/motd    
echo '' >> /etc/motd                    # Blank line to prevent overwrite at reboot
cat "files/motd/$HOST.motd" >> /etc/motd

# Configure a new .vimrc
echo $TEXT_COLOR''Setting up ~/.bashrc''$DEFAULT_COLOR
/bin/cp "files/.vimrc" ~/.vimrc

# Generate and append PS1 to .profile
echo $TEXT_COLOR''Generating a PS1 with ./sh/genPS1.sh''$DEFAULT_COLOR
ps1="`./sh/genPS1.sh`"
if [[ -z "`grep PS1 ~/.profile`" ]];then
    echo "PS1=\"$ps1\"" >> ~/.profile
else
    mv ~/.profile ~/.profile.tmp
    sed -e "s/^PS1\(.*\)$/PS1=\"$ps1\"/" ~/.profile.tmp > ~/.profile
    #rm ~/.profile.tmp
fi
. ~/.profile

# Configure /etc/hostname.em0
echo $TEXT_COLOR''Setting up /etc/hostname.em0''$DEFAULT_COLOR
cat > /etc/hostname.em0 <<EOF
# Overwrite by install script
inet $IP $NETMASK
EOF

# Configure /etc/mygate
echo $TEXT_COLOR''Setting up /etc/mygate''$DEFAULT_COLOR
cat > /etc/mygate <<EOF
# Overwrite by install script
$GATEWAY
EOF

# Configure /etc/resolv.conf
echo $TEXT_COLOR''Setting up /etc/resolv.conf''$DEFAULT_COLOR
cat > /etc/resolv.conf <<EOF
domain $DOMAIN
search $DOMAIN
nameserver 192.168.1.1
options rotate
lookup file bind
EOF

# Configure /etc/network/interfaces
echo $TEXT_COLOR''Restarting networking service''$DEFAULT_COLOR
/bin/sh /etc/netstart 

