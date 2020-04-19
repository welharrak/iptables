#! /bin/bash
# walid el harrak
# isx48144165
# iptables INPUT

# CAS 1: tanquem port 13 desde qualsevol IP
iptables -A INPUT -p tcp --dport 13 -j DROP

# CAS 2: tanquem port 13 només a host i obert a tothom
iptables -A INPUT -s 172.18.0.1 -p tcp --dport 13 -j DROP
iptables -A INPUT -p tcp --dport 13 -j ACCEPT

# CAS 3: tanquem port 13 a tohtom menys IP 172.18.0.3
iptables -A INPUT -s 172.18.0.3 -p tcp --dport 13 -j ACCEPT
iptables -A INPUT -p tcp --dport 13 -j DROP

# CAS 4: tancat al IP 172.18.0.3 però obert a xarxa docker
iptables -A INPUT -p tcp --dport 7 -s 172.18.0.3 -j DROP
iptables -A INPUT -p tcp --dport 7 -s 172.18.0.0/24 -j ACCEPT
iptables -A INPUT -p tcp --dport 7 -j DROP


