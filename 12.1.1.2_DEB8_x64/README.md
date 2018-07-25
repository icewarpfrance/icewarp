# Darnis - IceWarp France <h1>

IceWarp est le meilleur serveur de communication présent sur le marché.
Cette image vous permet d'obtenir un serveur de communication (mail, chat, téléphonie, conférence, partage de documents, ...) opérationnel en moins de cinq minutes.
Icewarp est un produit sous licence avec un excellent rapport qualité prix.
Bien sûr, le contailer que vous lancerez sera opérationnel en quelques minutes, vous pouvez l'utiliser pour monter un POC ou pour le tester mais, si vous souhaitez passer en production, en fonction de vos besoins, vous devrez penser :
* à la redondance
* au stockage
* aux sauvegardes
* à la supervision

Si vos ingénieurs sont disponibles, ce ne sera pas un soucis, sinon n'hésitez contactez Darnis - IceWarp France (info@icewarp.fr).

#### Avant premier lancement :<h4>
    mkdir /data/config /data/mail /data/logs /data/temp /data/spam /data/calendar
    chmod a+rwx /data/config /data/mail /data/logs /data/temp

#### Lancement en prenant les ports et adresses du host :<h4>
    `docker run --hostname hosticewarp0 -p 25:25/tcp -p 587:587/tcp -p 465:465/tcp -p 110:110/tcp -p 995:995/tcp -p 143:143/tcp -p 993:993/tcp -p 5222:5222/tcp -p 5223:5223/tcp -p 5269:5269/tcp -p 5060:5060/udp -p 5060:5060/tcp -p 5061:5061/udp -p 10000-10256:10000-10256/udp -p 80:80/tcp -p 443:443/tcp -p 1080:1080/tcp -p 5229:5229/tcp -v /data/config:/opt/icewarp/config -v /data/mail:/opt/icewarp/mail -v /data/logs:/opt/icewarp/logs -v /data/temp:/opt/icewarp/temp -v /data/spam:/opt/icewarp/spam -v /data/calendar:/opt/icewarp/calendar --name container0_icewarp -d icewarpfrance/icewarp:latest`

##### variables :<h5>
    Ces variables peuvent être positionnées avec la commande run, sinon elles seront valorisées au premier démarrage.
      -e PUBLICIP='x.x.x.x'
      -e LOCALIP='x.x.x.x'
      -e DNSSERVER='x.x.x.x'

#### configuration initiale :<h4>
    docker exec -it container0_icewarp /opt/icewarp/wizard.sh
       Pour :
          - activer la licence (eventuellement d'evaluation)
          - Creer un domaine
          - Creer un compte d'administration

#### Entrer en bash dans le container :<h4>
    docker exec -it container0_icewarp bash

#### Arret et redemarrage de l'instance :<h4>
    docker stop -t 120 container0_icewarp
      (laisser 120s ou plus pour arrêter correctement les services IceWarp)
    docker restart container0_icewarp

#### Construction :<h4>
    Si nécessaire, adaptez le Dockerfile
    docker build . --tag icewarp:latest
