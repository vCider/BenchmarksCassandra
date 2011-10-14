#!/bin/bash 

rm  nodes.ovpn

for hosts in `cat nodes.1`; do  ssh -i /home/ubuntu/vcider.pem ubuntu@$hosts "sudo /etc/init.d/openvpn restart" > /dev/null 2>&1 ; done

sleep 5

for hosts in `cat nodes`; do  ssh -i /home/ubuntu/vcider.pem ubuntu@$hosts "ifconfig tun0 | grep 'inet addr:' | cut -d: -f2 | cut -dP -f1 " >> nodes.ovpn ; done

exit 0

