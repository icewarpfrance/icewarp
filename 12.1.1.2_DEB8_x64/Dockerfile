# vim:set ft=dockerfile:
#
# Construction :
#    docker build /root/icewarp --tag icewarp:latest
#
# Avant premier lancement :
#    mkdir /data/config /data/mail /data/logs /data/temp /data/spam /data/calendar
#    chmod a+rwx /data/config /data/mail /data/logs /data/temp
#
# Lancement en prenant les ports et adresses du host :
#    docker run --hostname hosticewarp0 -p 25:25/tcp -p 587:587/tcp -p 465:465/tcp -p 110:110/tcp -p 995:995/tcp -p 143:143/tcp -p 993:993/tcp -p 5222:5222/tcp -p 5223:5223/tcp -p 5269:5269/tcp -p 5060:5060/udp -p 5060:5060/tcp -p 5061:5061/udp -p 10000-10256:10000-10256/udp -p 80:80/tcp -p 443:443/tcp -p 1080:1080/tcp -p 5229:5229/tcp -v /data/config:/opt/icewarp/config -v /data/mail:/opt/icewarp/mail -v /data/logs:/opt/icewarp/logs -v /data/temp:/opt/icewarp/temp -v /data/spam:/opt/icewarp/spam -v /data/calendar:/opt/icewarp/calendar --name container0_icewarp -d icewarpfrance/icewarp:latest
#
# configuration initiale
#    docker exec -it container0_icewarp /opt/icewarp/wizard.sh
#       Pour :
#          - activer la licence (eventuellement d'evaluation)
#          - Creer un domaine
#          - Creer un compte d'administration
#
# Entrer en bash dans le container :
#    docker exec -it container0_icewarp bash
#
# Arret et redemarrage de l'instance :
#    docker stop -t 120 container0_icewarp
#      (laisser 120s ou plus pour arrêter correctement les services IceWarp)
#    docker restart container0_icewarp
#
FROM debian:jessie
MAINTAINER Darnis - IceWarp France
ARG url="http://www.icewarp.fr/download/executables/linux"
ARG site="fr"
ARG file="IceWarpServer-12.1.1.2_DEB8_x64"
ARG fileToDownload="${url}/${file}.${site}.tar.gz"
COPY icewarpForever.sh /usr/local/bin
RUN set -ex; \
        export DEBIAN_FRONTEND=noninteractive ; \
        /usr/bin/dpkg --add-architecture i386 ; \
        /usr/bin/apt-get update -y; \
        /usr/bin/apt-get install wget apt-utils dialog apt-utils -y; \
        /usr/sbin/groupadd -r icewarp && /usr/sbin/useradd -r -g icewarp icewarp ; \
        /usr/bin/wget -q -O /tmp/${file}.${site}.tar.gz ${fileToDownload} ; \
        /bin/tar xzf /tmp/${file}.${site}.tar.gz -C /tmp; \
        /bin/cp /tmp/${file}/platform /tmp/${file}/platform.original ;\
        /bin/sed -i 's?>/dev/tty??' /tmp/${file}/platform ;\
        /tmp/${file}/install.sh --AUTO --INSTALL-DIR /opt/icewarp --USER icewarp ;\
        cd /opt/icewarp ;\
        /bin/tar czf calendar.tgz calendar ;\
        /bin/tar czf spam.tgz spam ;\
        /bin/tar czf config.tgz config ;\
        /bin/chmod 755 /usr/local/bin/icewarpForever.sh ;\
        /usr/bin/mkdir /opt/icewarp/licences ;\
        /usr/bin/touch /opt/icewarp/licenses/license.sh ;\
        /bin/chmod 755 /opt/icewarp/licenses/license.sh \;
        /usr/bin/sed 's?^.*IWS_INSTALL_DIR.*?[ ! -f /opt/icewarp/licenses/license.sh ] || /opt/icewarp/licenses/license.sh || exit\n&?' /opt/icewarp/wizard.sh
COPY license.sh /opt/icewarp/licenses/license.sh
# IceWarp persistent folders :
#    config                      : /opt/icewarp/config
#    mails                       : /opt/icewarp/mail
#    logs                        : /opt/icewarp/logs
#    temp                        : /opt/icewarp/temp
#    binaries                    : /opt/icewarp
#    antispam db and definitions : /opt/icewarp/spam
#    gw db and definitions       : /opt/icewarp/calendar
VOLUME ["/opt/icewarp/config", "/opt/icewarp/mail", "/opt/icewarp/logs", "/opt/icewarp/temp", "/opt/icewarp/spam", "/opt/icewarp/calendar"]
# IceWarp default ports
#    SMTP                   : 25, 587, 465
#    POP3                   : 110, 995
#    IMAP                   : 143, 993
#    Messagerie Instantanée : 5222, 5223, 5269
#    VoIP                   : 5060 (UDP), 5060, 5061, 10000-10256 (UDP)
#    Web                    : 80, 443
#    SOCKS                  : 1080
#    GroupWare              : 5229
EXPOSE 25/tcp 587/tcp 465/tcp 110/tcp 995/tcp 143/tcp 993/tcp 5222/tcp 5223/tcp 5269/tcp 5060/udp 5060/tcp 5061/udp 10000-10256/udp 80/tcp 443/tcp 1080/tcp 5229/tcp
CMD ["icewarpForever.sh"]
