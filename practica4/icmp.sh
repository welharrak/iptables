#! /bin/bash
# walid el harrak
# isx48144165
# iptables ICMP

# CAS 1: No podem fer pings a cap host
iptables -A OUTPUT -p icmp --icmp-type 8 -j DROP

# CAS 2: No podem fer ping a un host específic
iptables -A OUTPUT -d 172.18.0.3 -p icmp --icmp-type 8 -j DROP

# CAS 3: No responem cap ping
iptables -A OUTPUT -p icmp --icmp-type 0 -j DROP

# CAS 4: No acceptem les respostes del ping
iptables -A INPUT -p icmp --icmp-type 0 -j DROP
