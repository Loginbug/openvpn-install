#!/bin/sh

echo "Which port do you want to open?"
read PORT

echo "Which type of port? tcp OR udp?"
read TYPE

echo "For which client?"
read CLIENT_IP

#PORT=8080
#TYPE=tcp
#CLIENT_IP=10.8.0.2
VPN_IP=10.8.0.1

def_iface=$(route 2>/dev/null | grep -m 1 '^default' | grep -o '[^ ]*$')

iptables -t nat -A PREROUTING -i $def_iface -p $TYPE --dport $PORT -j DNAT --to-dest $CLIENT_IP:$PORT
iptables -t nat -A POSTROUTING -d $CLIENT_IP -p $TYPE --dport $PORT -j SNAT --to-source $VPN_IP

echo "Done"
