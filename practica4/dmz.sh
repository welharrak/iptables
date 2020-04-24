#! /bin/bash
# walid el harrak
# isx48144165
# iptables DMZ

# ORDES NECESSÀRIES PEL FUNCIONAMENT (CAS 4)
iptables -A FORWARD  -d 172.21.0.2 -i eth0@if7 -p tcp --dport 80 -j ACCEPT 
iptables -A FORWARD  -s 172.21.0.2 -o eth0@if7 -p tcp --sport 80 -m state --state ESTABLISHED,RELATED -j ACCEPT 

iptables -A FORWARD  -d 172.21.0.2 -i eth0@if7 -p tcp --dport 22 -j ACCEPT 
iptables -A FORWARD  -s 172.21.0.2 -o eth0@if7 -p tcp --sport 22 -m state --state ESTABLISHED,RELATED -j ACCEPT 

# CAS 1: la xarxa .21 només pot accedir del router als serveis ssh
iptables -A INPUT -s 172.21.0.0/24 -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -s 172.21.0.0/24 -j DROP

# CAS 2: la xarxa .21 nomès pot accedir a l'exterior als serveis web
iptables -A FORWARD  -s 172.21.0.0/24 -p tcp --dport 80 -o enp6s0   -j ACCEPT
iptables -A FORWARD  -d 172.21.0.0/24 -p tcp --sport 80 -i enp6s0 -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -A FORWARD  -s 172.21.0.0/24 -o eth0@if15 -j DROP
iptables -A FORWARD -d 172.21.0.0/24 -i eth0@if15 -j DROP

# CAS 3: la xarxa .21 només es pot accedir serveis web de la xarxa DMZ (.23)
iptables -A FORWARD -s 172.21.0.0/24 -d 172.23.0.0/24 -p tcp --dport 80 -j ACCEPT
iptables -A FORWARD -s 172.21.0.0/24 -d 172.23.0.0/24 -j DROP

# CAS 4: redirigir els ports perquè des de l'exterior es tingui accés a:
# 50123 = host1A:80 / 50124 = host2A:22
iptables -t nat -A PREROUTING -i eth0@if7 -p tcp --dport 50123 -j DNAT --to 172.21.0.2:80
iptables -t nat -A PREROUTING -i eth0@if7 -p tcp --dport 50124 -j DNAT --to 172.21.0.3:22

# CAS 5: s'obre el port 45000 per accedir al port ssh del router si la ip origen és de host2A
iptables -t nat -A PREROUTING -i eth0@if7 -p tcp --dport 45000 -s 172.21.0.3 -j DNAT --to :22

# CAS 6: els hosts de la xarxa .22 no tenen accès a la xarxa .21
iptables -A FORWARD -s 172.22.0.0/24  -d 172.21.0.0/24 -j DROP
iptables -A FORWARD -s 172.22.0.0/24 -j ACCEPT

