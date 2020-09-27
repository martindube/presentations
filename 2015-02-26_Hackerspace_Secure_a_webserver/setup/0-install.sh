#!/bin/ksh
./1-setupVM.sh
./2-customVM.sh -h 'obsdhs' -d 'hf' -i '192.168.1.105' -n '255.255.255.0' -g '192.168.1.1'
./3-installNginx.sh
# ./4-installChal1.sh

