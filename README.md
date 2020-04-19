# IPTABLES
## default.sh
- Accions bàsiques de configuració d'un script de iptables:
1. Esborar les regles (flush) i comptadors actuals
2. Regles per defecte
3. Obrir la connectivitat pròpia al loopback i a la propia adreça ip
4. <Definir si el host fa de router

## input.sh
- En aquest script, juguem entre dos containers (a l'hora de fer del docker run, s'ha d'afegir **--cap-add=NET_ADMIN** al container que fara de host per a que funcioni l'ordre **iptables**):
```
docker run --rm -h host --cap-add=NET_ADMIN --net mynet -it fedora:27 /bin/bash
* S'hauran d'instalar paquest necessaris
```
- Regles:

1. Tanquem port 13 desde qualsevol IP
2. Tanquem port només a host (172.18.0.1) i obert a tothom
3. Tanquem port 13 a tohtom menys IP 172.18.0.3
4. Tancat al IP 172.18.0.3 però obert a xarxa docker
