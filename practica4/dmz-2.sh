#! /bin/bash
# walid el harrak
# isx48144165
# iptables DMZ (2)

# CAS 1: Des d'un host exterior accedir al servei ldap de la DMZ.
iptables -t nat -A PREROUTING -p tcp --dport 389 -i eth0@if7 -j DNAT --to 172.23.0.2:389
iptables -t nat -A PREROUTING -p tcp --dport 636 -i eth0@if7 -j DNAT --to 172.23.0.2:636

# CAS 2: Des d'un host exterior, engegar un container kclient i 
# obtenir un tiket kerberos del servidor de la DMZ.
iptables -t nat -A PREROUTING -p tcp --dport 88 -i eth0@if7 -j DNAT --to 172.23.0.3:88
iptables -t nat -A PREROUTING -p tcp --dport 543 -i eth0@if7 -j DNAT --to 172.23.0.3:543
iptables -t nat -A PREROUTING -p tcp --dport 749 -i eth0@if7 -j DNAT --to 172.23.0.3:749
iptables -t nat -A PREROUTING -p tcp --dport 544 -i eth0@if7 -j DNAT --to 172.23.0.3:544

# CAS 3: Des d'un host exterior muntar un recurs samba del servidor de la DMZ
iptables -t nat -A PREROUTING -p tcp --dport 139 -i eth0@if7 -j DNAT --to 172.23.0.4:139
iptables -t nat -A PREROUTING -p tcp --dport 445 -i eth0@if7 -j DNAT --to 172.23.0.4:445