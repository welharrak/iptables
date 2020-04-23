#! /bin/bash
# walid el harrak
# isx48144165
# iptables PORT-FORWARDING

# CAS 1: Dirigir tot el tràfic http a un altre host de la LAN
iptables -t nat -A PREROUTING -i eth0@if7 -p tcp --dport 80 -j DNAT --to 172.18.0.3:80

# CAS 2: Ports actuen com camins per accedir a serveis interns de la LAN
iptables -t nat -A PREROUTING -i eth0@if7 -p tcp --dport 50123 -j DNAT --to 172.18.0.3:50000

# CAS 3: Quan tràfic provingui de 172.18.0.2 enviar-lo a host 172.20.0.2:80
iptables -t nat -A PREROUTING -s 172.18.0.2 -i eth0@if7 -p tcp --dport 80 -j DNAT --to 172.20.0.2:80

# CAS 4: Quan tràfic provingui de xarxa .19 enviar-lo a host 172.20.0.2:80
iptables -t nat -A PREROUTING -s 172.18.0.0/24 -i eth0@if7 -p tcp --dport 80 -j DNAT --to 172.20.0.2:80