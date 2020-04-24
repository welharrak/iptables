# IPTABLES
## default.sh
- Accions bàsiques de configuració d'un script de iptables:
1. Esborar les regles (flush) i comptadors actuals
2. Regles per defecte
3. Obrir la connectivitat pròpia al loopback i a la propia adreça ip
4. Definir si el host fa de router

## Per fer les següent proves, podem utilitzar containers docker
- Juguem entre dos o més containers (a l'hora de fer del docker run, s'ha d'afegir **--cap-add=NET_ADMIN** al container que fara de host per a que funcioni l'ordre **iptables**):
```
docker run --rm -h host --cap-add=NET_ADMIN --net mynet -it fedora:27 /bin/bash
* S'hauran d'instalar paquest necessaris
```

## input.sh
- De fora a dins

1. Tanquem port per a qualsevol IP
2. Tanquem port només a host (172.18.0.1) i obert a tothom
3. Tanquem port a tohtom menys IP 172.18.0.3
4. Tancat al IP 172.18.0.4 però obert a xarxa docker

## output.sh
- De dins a fora

1. Accès total a qualsevol port (destí)
2. Accès al port 7 de qualsevol host de la xarxa docker
3. Accès a qualsevol port 13, menys a una IP específica
4. Nomès accès al port 7 d'un host
5. No es permet accedir a un host específic
6. No es permet accedir a una xarxa específica
7. Podem accedir al port 7 de qualsevol destí

## established.sh
- Identificar tràfic de resposta (RELATED, ESTABLISHED).

1. Oferim el servei web però només permetem respostes a peticions establertes
2. Permetem al host sortir a l'exterior, però no accepta connexions web.
3. Deixem fer de tot al tràfic ja establert
4. Obrim el nostre servei web a tothom menys a un host específic

## icmp.sh
- Tràfic ICMP de ping request (8) i ping reply (0)

1. No podem fer pings a cap host
2. No podem fer ping a un host específic
3. No responem cap ping
4. No acceptem les respostes del ping

## nat.sh
Activar NAT per a dues xarxes internes, en aquest cas xarxes docker:
- Creem dos xarxes docker
- Engegar dos containers a cada xarxa.
- Eliminar totes les regles de iptables aplicant l'script default.sh
- Una vegada eliminades les regles, no tenen connexió a l'exterior. Haurem d'aplicar el  NAT per a les dues xarxes per verificar que tornen a tenir connectivitat a l'exterior.

- Estructurra:
```
[isx48144165@walid ~]$ docker network create mynet yournet
[isx48144165@walid ~]$ docker run --rm --name host1A -h host1A --net mynet --privileged -d welharrak/iptables
[isx48144165@walid ~]$ docker run --rm --name host1B -h host1B --net mynet --privileged -d welharrak/iptables
[isx48144165@walid ~]$ docker run --rm --name host2A -h host2A --net yournet --privileged -d welharrak/iptables
[isx48144165@walid ~]$ docker run --rm --name host2B -h host2B --net yournet --privileged -d welharrak/iptables
```

## forwarding.sh
- Forwarding: router parla en nom dels hosts i els contesta les respostes

1. Una xarxa no pot accedir a una altra xarxa externa
2. Host 172.18.0.2 no pot accedir a una xarxa externa
3. Xarxa no pot accedir al servei web de 172.18.0.2
4. Cap host de la d'una xarxa pot sortir des del port 7
5. Evitar **spoofing**: des de dins de la LAN es falsifiqui ip origen

## port-forwarding.sh

- Port redirigeix a un altre port

1. Dirigir tot el tràfic http a un altre host de la LAN
2. Ports actuen com camins per accedir a serveis interns de la LAN
3. Quan tràfic provingui d'un host enviar-lo a un altre host
4. Quan tràfic provingui d'una xarxa enviar-lo a un host

## dmz.sh
- Demilitarized zone: xarxa local que es troba entre la xarxa interna i una xarxa externa

1. La xarxa a només pot accedir del router als serveis ssh
2. La xarxa a només pot accedir a l'exterior als serveis web
3. la xarxa a només es pot accedir serveis web de la xarxa DMZ 
4. Redirigir els ports perquè des de l'exterior es tingui accés a x ports de x hosts
5. S'obre un port per accedir al port ssh del router si la ip origen és de host2A
6. Els hosts de la xarxa b no tenen accès a la xarxa a

- Estructura:
```
docker network create A B DMZ
docker run --rm --name host1A -h host1A --net A --privileged -d welharrak/iptables
docker run --rm --name host2B -h host2B --net A --privileged -d welharrak/iptables
docker run --rm --name host1A -h host1A --net B --privileged -d welharrak/iptables
docker run --rm --name host2B -h host2B --net B --privileged -d welharrak/iptables
docker run --rm --name dmz1 -h dmz1 --net DMZ --privileged -d welharrak/iptables
docker run --rm --name dmz2 -h dmz2 --net DMZ --privileged -d welharrak/ldapserver19:latest
```

## dmz-2.sh
- Configurar un host amb dues xarxes privades locals xarxaA i xarxaB i una tercera xarxa DMZ amb servidors: nethost, ldap, kerberos, samba. Implementar-ho amb containers i xarxes docker.

- Exercicis:
1. Des d'un host exterior accedir al servei ldap de la DMZ. (Ports: 389, 636.)
2. Des d'un host exterior, engegar un container kclient i obtenir un tiket kerberos del servidor de la DMZ. (Ports: 88, 543, 749.)
3. Des d'un host exterior muntar un recurs samba del servidor de la DMZ. (Ports: 139, 445)

## drop.sh
- Tanquem tot
- Nomès deixem ports necesàris pel funcionament correcte de la màquina:
1. dns(53)
2. dhclient(68)
3. ssh(22)
4. rpc(111, 507)
5. chronyd(123, 371)
6. cups(631)
7. xinetd(3411)
8. postgresql(5432)
9. x11forwarding(6010, 6011)
10. avahi(368)
11. alpes(462)
12. tcpnethaspsrv(475)
13. rxe(761)



