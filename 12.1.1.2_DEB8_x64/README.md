# Serveur de Communication IceWarp
[To English version](#english)


### French

IceWarp est le meilleur serveur de communication présent sur le marché.
Cette image vous permet d'obtenir un serveur de communication (mail, chat, téléphonie, conférence, partage de documents, ...) opérationnel en moins de cinq minutes.

Icewarp est un produit sous licence avec un excellent rapport qualité prix. Cette image vous permet d'activer gratuitement une licence d'évaluation pour 30 jours, pour 200 utilisateurs, disposant de toutes les fonctionnalités.

Le container que vous lancerez sera opérationnel en quelques minutes, vous pouvez l'utiliser pour monter un POC ou pour le tester mais, si vous souhaitez l'utiliser en production, en fonction de vos besoins, vous devrez penser :
* à la redondance
* au stockage
* au remplacement de SQLite (utilisé par défaut, SQLite convient pour moins de 50 comptes)
* aux sauvegardes
* à la supervision

Si vos ingénieurs sont disponibles, ils sauront traiter ces points, sinon contactez nous : info@icewarp.fr.

#### Avant le premier lancement :
Configurez les dossiers qui contiendront les données persistentes.
    
`mkdir /data/config /data/mail /data/logs /data/temp /data/spam /data/calendar`

`chmod a+rwx /data/config /data/mail /data/logs /data/temp`

#### Lancement en prenant les ports et adresses du host :
`docker run --hostname hosticewarp0 -e 'TZ=Europe/Paris' -p 25:25/tcp -p 587:587/tcp -p 465:465/tcp -p 110:110/tcp -p 995:995/tcp -p 143:143/tcp -p 993:993/tcp -p 5222:5222/tcp -p 5223:5223/tcp -p 5269:5269/tcp -p 5060:5060/udp -p 5060:5060/tcp -p 5061:5061/udp -p 10000-10256:10000-10256/udp -p 80:80/tcp -p 443:443/tcp -p 1080:1080/tcp -p 5229:5229/tcp -v /data/config:/opt/icewarp/config -v /data/mail:/opt/icewarp/mail -v /data/logs:/opt/icewarp/logs -v /data/temp:/opt/icewarp/temp -v /data/spam:/opt/icewarp/spam -v /data/calendar:/opt/icewarp/calendar --name container0_icewarp -d icewarpfrance/icewarp:latest`

##### variables :
Les variables PUBLICIP, LOCALIP et DNSSERVER peuvent être positionnées avec la commande run, sinon, un script essaiera de les valoriser au premier démarrage pour configurer IceWarp.

`-e PUBLICIP='x.x.x.x'`

`-e LOCALIP='x.x.x.x'`

`-e DNSSERVER='x.x.x.x'`

#### configuration initiale :
`docker exec -it container0_icewarp /opt/icewarp/wizard.sh`
 
Pour :
- activer la licence (eventuellement d'evaluation)
- Creer un domaine
- Creer un compte d'administration

#### Entrer en bash dans le container :
`docker exec -it container0_icewarp bash`

#### Arrêt de l'instance :
`docker stop -t 120 container0_icewarp`

(laisser 120s ou plus pour arrêter correctement les services IceWarp)
 
#### Redémarrage de l'instance :
    
`docker restart container0_icewarp`

#### Construction :
Si nécessaire, adaptez le Dockerfile puis

`docker build . --tag icewarp:latest`

#### Pour davantage d'informations sur le serveur IceWarp :
Consultez nos guides sur http://www.icewarp.fr ou contactez nous en écrivant à info@darnis.com ou info@icewarp.fr.

#### Exemple de création d'une machine docker dans le cloud OVH :

A écrire.

### French

[Vers la version française](#Français)

To be written.

**Darnis - IceWarp France**
