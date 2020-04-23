#! /bin/bash
# walid el harrak
# isx48144165
# iptables FORWARDING

# CAS 1: Xarxa .18 no pot accedir a xarxa .19
iptables -A FORWARD -s 172.18.0.0/24 -d 172.19.0.0/24 -j DROP

# CAS 2: Host 172.18.0.2 no pot accedir a xarxa .19
iptables -A FORWARD -s 172.18.0.2/24 -d 172.19.0.0/24 -j DROP

# CAS 3: Xarxa 19 no pot accedir al servei web de 172.18.0.2
iptables -A FORWARD -s 172.19.0.0/24 -d 172.18.0.2 -p tcp --dport 80 -j DROP

# CAS 4: Cap host de la xarxa .18 pot sortir des del port 7
iptables -A FORWARD -s 172.18.0.0/24 -p tcp --dport 7 -j DROP

# CAS 5: Evitar que des de dins de la LAN es falsifiqui ip origen (spoofing)
iptables -A FORWARD ! -s 172.18.0.0/24 -i eth0@if15 -j DROP