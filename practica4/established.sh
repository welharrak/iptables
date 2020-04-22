#! /bin/bash
# walid el harrak
# isx48144165
# iptables ESTABLISHED

# CAS 1: oferim el servei web però només permetem respostes a peticions establertes.
iptables -A OUTPUT -p tcp --sport 80 -m tcp -m state --state RELATED,ESTABLISHED -j ACCEPT   
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# CAS 2: permetem al host sortir a l'exterior, però no accepta connexions web.
iptables -A INPUT -p tcp -m tcp --sport 80 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -m tcp --dport 80 -j ACCEPT

iptables -A INPUT -p tcp --dport 80 -j DROP

# CAS 3: Deixem fer de tot al tràfic ja establert
iptables -t filter -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t filter -A OUPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# CAS 4: Obrim el nostre servei web a tothom menys a host 172.18.0.3
iptables -A OUTPUT -p tcp --sport 80 -m tcp -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -s 172.18.0.3 -j REJECT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT