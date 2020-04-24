#! /bin/bash
# walid el harrak
# isx48144165
# iptables DROP

# Establim la politica per defecte DROP
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Permetem totes les pròpies connexions via localhost
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Permetre tot el trafic de la pròpia IP
iptables -A INPUT -s 192.168.1.15 -j ACCEPT
iptables -A OUTPUT -d 192.168.1.15 -j ACCEPT

# Obrir port DNS
iptables -A INPUT -p udp --sport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT

# Obrir port dhclient
iptables -A INPUT -p udp --dport 68 -j ACCEPT
iptables -A OUTPUT -p udp --sport 68 -j ACCEPT

# Obrir port SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# Obrir port rpc
iptables -A INPUT -p tcp --dport 111 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 111 -j ACCEPT

iptables -A INPUT -p tcp --dport 507 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 507 -j ACCEPT

# Obrir port chronyd
iptables -A INPUT -p tcp --dport 123 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 123 -j ACCEPT

iptables -A INPUT -p tcp --dport 371 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 371 -j ACCEPT
# Obrir port cups
iptables -A INPUT -p tcp --dport 631 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 631 -j ACCEPT

# Obrirport xinetd
iptables -A INPUT -p tcp --dport 3411 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 3411 -j ACCEPT

# Obrir port postgresql
iptables -A INPUT -p tcp --dport 5432 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 5432 -j ACCEPT

# Obrir port x11-x-forwarding
iptables -A INPUT -p tcp --dport 6010:6011 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 6010:6011 -j ACCEPT

# Obrir port avahi
iptables -A INPUT -p udp --dport 368 -j ACCEPT
iptables -A OUTPUT -p udp --sport 368 -j ACCEPT

# Obrir port alpes
iptables -A INPUT -p udp --dport 463 -j ACCEPT
iptables -A OUTPUT -p udp --sport 463 -j ACCEPT

# Obrir port tcpnethaspsrv
iptables -A INPUT -p udp --dport 475 -j ACCEPT
iptables -A OUTPUT -p udp --sport 475 -j ACCEPT

# Obrir port rxe
iptables -A INPUT -p tcp --dport 761 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 761 -j ACCEPT