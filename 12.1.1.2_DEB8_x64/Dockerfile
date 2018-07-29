# vim:set ft=dockerfile:
# Example :
#   docker build --build-arg VERSION=12.1.1.2 --build-arg URL=http://www.icewarp.fr/download/executables/linux --build-arg LANG=fr --build-arg OS=DEB9_x64 --build-arg FROMOS=debian --build-arg FROMOSVERSION=9 -t index.docker.io/icewarpfrance/icewarp:latest .
#
MAINTAINER Darnis - IceWarp France
ARG URL
ARG LANG
ARG OS
ARG VERSION
ARG FROMOS
ARG FROMOSVERSION
ARG file="IceWarpServer-${VERSION}_${OS}"
ARG fileToDownload="${file}.${LANG}.tar.gz"
ARG downloadURL="${URL}/${fileToDownload}"
FROM ${FROMOS}:${FROMOSVERSION}
COPY icewarpForever.sh /usr/local/bin
RUN set -ex; \
        export DEBIAN_FRONTEND=noninteractive ; \
        /usr/bin/dpkg --add-architecture i386 ; \
        /usr/bin/apt-get update -y; \
        /usr/bin/apt-get install wget apt-utils dialog apt-utils -y; \
        /usr/sbin/groupadd -r icewarp && /usr/sbin/useradd -r -g icewarp icewarp ; \
        /usr/bin/wget -q -O /tmp/${fileToDownload} ${downloadURL} ; \
        /bin/tar xzf /tmp/${fileToDownload} -C /tmp; \
        /bin/cp /tmp/${file}/platform /tmp/${file}/platform.original ;\
        /bin/sed -i 's?>/dev/tty??' /tmp/${file}/platform ;\
        /tmp/${file}/install.sh --AUTO --INSTALL-DIR /opt/icewarp --USER icewarp ;\
        cd /opt/icewarp ;\
        /bin/tar czf calendar.tgz calendar ;\
        /bin/tar czf spam.tgz spam ;\
        /bin/tar czf config.tgz config ;\
        /bin/chmod 755 /usr/local/bin/icewarpForever.sh ;\
        /bin/mkdir /opt/icewarp/license ;\
        /bin/sed -i -e 's?^.*IWS_INSTALL_DIR.*?[ ! -f /opt/icewarp/license/license.sh ] || /opt/icewarp/license/license.sh || exit\n&?' /opt/icewarp/wizard.sh ;\
        /bin/rm /tmp/${fileToDownload}
COPY license.sh /opt/icewarp/license/license.sh
RUN set -ex ;\
        /bin/chmod 755 /opt/icewarp/license/license.sh ;\
        /bin/cp /tmp/${file}/LICENSE* /opt/icewarp/license ;\
        /bin/chown -R icewarp:icewarp /opt/icewarp/license ;\
        /bin/rm -rf /tmp/${file}
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
