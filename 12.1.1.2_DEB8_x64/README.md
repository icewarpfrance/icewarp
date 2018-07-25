# Darnis - IceWarp France <h1>

## Construction :<h2>
    docker build /root/icewarp --tag icewarp:latest

### Avant premier lancement :<h3>
    mkdir /data/config /data/mail /data/logs /data/temp /data/spam /data/calendar
    chmod a+rwx /data/config /data/mail /data/logs /data/temp

### Lancement en prenant les ports et adresses du host :<h3>
    docker run --hostname hosticewarp0 -p 25:25/tcp -p 587:587/tcp -p 465:465/tcp -p 110:110/tcp -p 995:995/tcp -p 143:143/tcp -p 993:993/tcp -p 5222:5222/tcp -p 5223:5223/tcp -p 5269:5269/tcp -p 5060:5060/udp -p 5060:5060/tcp -p 5061:5061/udp -p 10000-10256:10000-10256/udp -p 80:80/tcp -p 443:443/tcp -p 1080:1080/tcp -p 5229:5229/tcp -v /data/config:/opt/icewarp/config -v /data/mail:/opt/icewarp/mail -v /data/logs:/opt/icewarp/logs -v /data/temp:/opt/icewarp/temp -v /data/spam:/opt/icewarp/spam -v /data/calendar:/opt/icewarp/calendar --name container0_icewarp -d icewarpfrance/icewarp:latest
#### variables :<h4>
      -e PUBLICIP='x.x.x.x'
      -e LOCALIP='x.x.x.x'
      -e DNSSERVER='x.x.x.x'

### configuration initiale :<h3>
    docker exec -it container0_icewarp /opt/icewarp/wizard.sh
       Pour :
          - activer la licence (eventuellement d'evaluation)
          - Creer un domaine
          - Creer un compte d'administration

### Entrer en bash dans le container :<h3>
    docker exec -it container0_icewarp bash

### Arret et redemarrage de l'instance :<h3>
    docker stop -t 120 container0_icewarp
      (laisser 120s ou plus pour arrêter correctement les services IceWarp)
    docker restart container0_icewarp
