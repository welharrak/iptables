#! /bin/bash
# walid el harrak
# isx48144165
# iptables INPUT

# CAS 1: tanquem port 13 desde qualsevol IP
iptables -A INPUT -p tcp --dport 13 -j DROP

# CAS 2: tanquem port només a host
iptables -A INPUT -s 172.18.0.1 -p tcp --dport 13 -j DROP



