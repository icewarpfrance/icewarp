# Serveur de Communication IceWarp
[To English version](#english)

### French
### Présentation
IceWarp est le meilleur serveur de communication présent sur le marché.
Cette image vous permet d'obtenir un serveur de communication (Email, Chat, Téléphonie, Conférence, Partage de documents, ...) opérationnel en moins de cinq minutes.

IceWarp est un produit sous licence avec un excellent rapport qualité prix. Cette image vous permet d'activer gratuitement une licence d'évaluation pour 30 jours, pour 200 utilisateurs, disposant de toutes les fonctionnalités.

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
docker run --hostname hosticewarp0 -e 'TZ=Europe/Paris' -p 25:25/tcp -p 587:587/tcp -p 465:465/tcp -p 110:110/tcp -p 995:995/tcp -p 143:143/tcp -p 993:993/tcp -p 5222:5222/tcp -p 5223:5223/tcp -p 5269:5269/tcp -p 5060:5060/udp -p 5060:5060/tcp -p 5061:5061/udp -p 10000-10256:10000-10256/udp -p 80:80/tcp -p 443:443/tcp -p 1080:1080/tcp -p 5229:5229/tcp -v /data/config:/opt/icewarp/config -v /data/mail:/opt/icewarp/mail -v /data/logs:/opt/icewarp/logs -v /data/temp:/opt/icewarp/temp -v /data/spam:/opt/icewarp/spam -v /data/calendar:/opt/icewarp/calendar --name container0_icewarp -d icewarpfrance/debian9:latest

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

Vous pouvez monter un POC pour un coût raisonable :
* en prenant une machine dans le cloud (exemple https://www.ovh.com/fr/public-cloud/instances/tarifs/) et l' construire avec l'OS de votre choix
* configurer docker (vous trouverez les instructions sur https://docs.docker.com/install/linux/docker-ce/debian/)
* récupérer une image sur https://hub.docker.com/u/icewarpfrance/, la lancer en suivant les instructions ci-dessus
* après avoir accepté la licence d'évaluation, créé un domaine et un compte, vous pouvez ensuite vous connecter en https à l'adresse de la machine et tester l'envoi de mails (impossible vers l'extérieur si les enregistrements DNS n'ont pas été configurés pour le serveur), tester la téléphonie entre deux comptes de votre machine ou appeler "echo" pour vérifier le bon fonctionnement. 

### English
[Vers la version française](#french)
### Summary
IceWarp is the best Unified COmmunications Server available on the market. This docker image brings to you in a simple way all the advanced features of the product (Email, Chat, Voice over IP, Webmeetings, Data sharing, ...) out of the box and ready for use in just under 5 minutes.

Icewarp is a commerical product with an excellent quality/price ratio. With this image, you can activate a 30-day evaluation licence for 200 mailboxes, all features included.

The container is perfectly suited for evaluations, tests, demonstrations, POC... As a next step, before using this image as a production server, yous hould consider the following points as per your needs : 

* redundnacy
* high performance storage
* a DBMS (SQLite packaged as default in the image is suitable for very small configurations only and does not allow the usage of the TeamChat feature)
* backups
* monitoring

If you do not have internal resources for these tasks, you may contact us at info@icewarp.fr.

#### Before the first launch :
You should onfigure the folders which will hold your data. For ex. if you want your data to be stored in /data, use the folllowing commands  :
    
`mkdir /data/config /data/mail /data/logs /data/temp /data/spam /data/calendar`

`chmod a+rwx /data/config /data/mail /data/logs /data/temp`

#### Run the image by binding the ports and folder paths :
You can modify the command to replace hosticewarp0 with the real hostname, 'TZ=Europe/Paris' with your timezone, /data/ with the actual folder names on your hst machine.

`docker run --hostname hosticewarp0 -e 'TZ=Europe/Paris' -p 25:25/tcp -p 587:587/tcp -p 465:465/tcp -p 110:110/tcp -p 995:995/tcp -p 143:143/tcp -p 993:993/tcp -p 5222:5222/tcp -p 5223:5223/tcp -p 5269:5269/tcp -p 5060:5060/udp -p 5060:5060/tcp -p 5061:5061/udp -p 10000-10256:10000-10256/udp -p 80:80/tcp -p 443:443/tcp -p 1080:1080/tcp -p 5229:5229/tcp -v /data/config:/opt/icewarp/config -v /data/mail:/opt/icewarp/mail -v /data/logs:/opt/icewarp/logs -v /data/temp:/opt/icewarp/temp -v /data/spam:/opt/icewarp/spam -v /data/calendar:/opt/icewarp/calendar --name container0_icewarp -d icewarpfrance/debian9:latest`

##### Variables :
You can provide PUBLICIP, LOCALIP and DNSSERVER as arguments to the run command, else, a script will pick up the values based on the network configuration of the container.

`-e PUBLICIP='x.x.x.x'`

`-e LOCALIP='x.x.x.x'`

`-e DNSSERVER='x.x.x.x'`

#### Initial configuration :
The first command to run must be :
`docker exec -it container0_icewarp /opt/icewarp/wizard.sh`
 
This command will allow you to :
- Activate the license (evaluation or purchase)
- Create a domain
- Create an account with adminisator rights

#### To get inside the container with the bash shell :
`docker exec -it container0_icewarp bash`

#### To stop the container :
`docker stop -t 120 container0_icewarp`

(laisser 120s ou plus pour arrêter correctement les services IceWarp)
 
#### To restart the container :
    
`docker restart container0_icewarp`

#### Build :
Adapt the Dockerfile as needed and then,

`docker build . --tag icewarp:latest`

#### For more information on the IceWarp Server :
Consult the documentation available on http://www.icewarp.fr or contact us by email : info@darnis.com or info@icewarp.fr.

#### How to easily create a docker machine in the OVH cloud  :

To prepare a POC at a reasonable cost :
* register a machine in the cloud and install the host with the OS of your choice (https://www.ovh.com/fr/public-cloud/instances/tarifs/)
* configure docker (you will find the instructions here : https://docs.docker.com/install/linux/docker-ce/debian/)
* pickup an image on https://hub.docker.com/u/icewarpfrance/, and run it as per the instructions above
* after having accepted the evaluation license, created a domain and an account, you can connect to WebClient and WebAdmin by using the URLs https://<server-name-or-IP> and https://<server-name-or-IP>/admin/ resp. You have immediate access to email, calendaring, sharing, Voice over IP (make a call to the 'echo' service to verify that the WebPhone is working).

**Darnis - IceWarp France**
