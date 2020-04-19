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
- Regles:

1. Tanquem port per a qualsevol IP
2. Tanquem port només a host (172.18.0.1) i obert a tothom
3. Tanquem port a tohtom menys IP 172.18.0.3
4. Tancat al IP 172.18.0.4 però obert a xarxa docker

## output.sh
- De dins a fora
- Regles:

1. Accès total a qualsevol port (destí)
2. Accès al port 7 de qualsevol host de la xarxa docker
3. Accès a qualsevol port 13, menys a una IP específica
4. Nomès accès al port 7 d'un host 
5. No es permet accedir a un host específic
6. No es permet accedir a una xarxa específica
7. Podem accedir al port 7 de qualsevol destí