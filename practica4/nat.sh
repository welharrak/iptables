#! /bin/bash
# walid el harrak
# isx48144165
# iptables NAT

# Fer NAT per les xarxes internes:

iptables -t nat -A POSTROUTING -s 172.20.0.0/24 -o enp1s0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.21.0.0/24 -o enp1s0 -j MASQUERADE