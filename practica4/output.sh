#! /bin/bash
# walid el harrak
# isx48144165
# iptables OUTPUT

# CAS 1: podem accedir a qualsevol port (destí)
iptables -A OUTPUT -j ACCEPT 

# CAS 2: podem accedir al port 7 de qualsevol host de la xarxa 172.18.0.0/24
iptables -A OUTPUT -p tcp --dport 7 -d 172.18.0.0/24  -j ACCEPT

# CAS 3: podem accedir a qualsevol port 13, menys del host 172.18.0.3 
iptables -A OUTPUT -p tcp --dport 13 -d 172.18.0.3 -j DROP
iptables -A OUTPUT -p tcp --dport 13 -j ACCEPT

# CAS 4: nomès poder accedir al port 7 de host 172.18.0.4
iptables -A OUTPUT -p tcp --dport 7 -d 172.18.0.4 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 7 -j DROP

# CAS 5: no podem accedir al host 172.18.0.3
iptables -A OUTPUT -d 172.18.0.3 -j REJECT

# CAS 6: no podem accedir a la xarxa docker
iptables -A OUTPUT -d 172.18.0.0/24 -j REJECT

# CAS 7: podem accedir al port 7 de qualsevol destí
iptables -A OUTPUT -p tcp --dport 7 -d 0.0.0.0/0  -j ACEEPT