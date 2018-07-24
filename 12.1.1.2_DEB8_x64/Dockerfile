# vim:set ft=dockerfile:
FROM debian:jessie
MAINTAINER Darnis - IceWarp France version: 0.1
ARG url="http://www.icewarp.fr/download/executables/linux"
ARG site="fr"
ARG file="IceWarpServer-12.1.1.2_DEB8_x64"
ARG fileToDownload="${url}/${file}.${site}.tar.gz"
RUN set -ex; \
        export DEBIAN_FRONTEND=noninteractive ; \
        echo "TRACE1 $?" ;\
        /usr/bin/dpkg --add-architecture i386 ; \
        echo "TRACE2 $?" ;\
        /usr/bin/apt-get update -y; \
        echo "TRACE3 $?" ;\
        /usr/bin/apt-get install wget apt-utils dialog apt-utils -y; \
        echo "TRACE4 $?" ;\
        /usr/sbin/groupadd -r icewarp && /usr/sbin/useradd -r -g icewarp icewarp ; \
        echo "TRACE5 $?" ;\
        /usr/bin/wget -q -O /tmp/${file}.${site}.tar.gz ${fileToDownload} ; \
        echo "TRACE6 $?" ;\
        /bin/tar xzf /tmp/${file}.${site}.tar.gz -C /tmp; \
        echo "TRACE7 $?" ;\
        /bin/cp /tmp/${file}/platform /tmp/${file}/platform.original ;\
        echo "TRACE8 $?" ;\
        /bin/sed -i 's?>/dev/tty??' /tmp/${file}/platform ;\
        echo "TRACE9 $?" ;\
        /bin/sed -i 's/.*apt-get.*install.*/& ; echo "APTGETSTATUS $?"/' /tmp/${file}/platform ;\
        echo "TRACE9.1 $?" ;\
        /bin/sed -i 's/.*dpkg.*-i.*/& ; echo "DPKGSTATUS $?"/' /tmp/${file}/platform ;\
        echo "TRACE9.2 $?" ;\
        /tmp/${file}/install.sh --AUTO --INSTALL-DIR /opt/icewarp --USER root ;\
        echo "TRACE10 $?" ;\
        cd /opt/icewarp ;\
        echo "TRACE11 $?" ;\
        tar czf calendar.tgz calendar ;\
        /bin/sed -i 's?>/dev/tty??' /tmp/${file}/platform ;\
        echo "TRACE9 $?" ;\
        echo "TRACE12 $?" ;\
        tar czf spam.tgz spam ;\
        echo "TRACE13 $?" ;\
        tar czf config.tgz config ;\
        echo "TRACE14 $?" ;\
        echo '#!/bin/bash'                                          > /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE15 $?" ;\
        echo 'set -e'                                              >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE16 $?" ;\
        echo 'stopIceWarpService()'                                >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE17 $?" ;\
        echo '{'                                                   >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE18 $?" ;\
        echo '   /usr/sbin/service icewarp stop'                   >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE19 $?" ;\
        echo '   exitStatus=$?'                                    >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE20 $?" ;\
        echo '   /bin/kill -TERM "${childPid}" 2>/dev/null'        >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE21 $?" ;\
        echo '   exit $exitStatus'                                 >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE22 $?" ;\
        echo '}'                                                   >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE23 $?" ;\
        echo 'if test -f /opt/icewarp/calendar.tgz'                >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE24 $?" ;\
        echo 'then'                                                >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE25 $?" ;\
        echo '   /bin/chown icewarp:icewarp /opt/icewarp/config'   >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE26 $?" ;\
        echo '   /bin/chown icewarp:icewarp /opt/icewarp/mail'     >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE27 $?" ;\
        echo '   /bin/chown icewarp:icewarp /opt/icewarp/logs'     >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE28 $?" ;\
        echo '   /bin/chown icewarp:icewarp /opt/icewarp/temp'     >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE29 $?" ;\
        echo '   /bin/chown icewarp:icewarp /opt/icewarp/spam'     >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE30 $?" ;\
        echo '   /bin/chown icewarp:icewarp /opt/icewarp/calendar' >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE31 $?" ;\
        echo '   cd /opt/icewarp'                                  >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE32 $?" ;\
        echo '   tar xzf calendar.tgz calendar/'                   >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE33 $?" ;\
        echo '   tar xzf spam.tgz     spam/'                       >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE34 $?" ;\
        echo '   tar xzf config.tgz   config/'                     >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE35 $?" ;\
        echo '   rm calendar.tgz spam.tgz config.tgz'              >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE36 $?" ;\
        echo 'fi'                                                  >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE37 $?" ;\
        echo '/usr/sbin/service icewarp start'                     >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE38 $?" ;\
        echo 'trap stopIceWarpService TERM'                        >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE39 $?" ;\
        echo 'sleep infinity &'                                    >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE40 $?" ;\
        echo 'childPid=$!'                                         >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE42 $?" ;\
        echo 'wait ${childPid}'                                    >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE42 $?" ;\
        echo 'trap - TERM'                                         >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE43 $?" ;\
        echo 'wait ${childPid}'                                    >> /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE44 $?" ;\
        /bin/chmod 755 /usr/local/bin/icewarpForever.sh ; \
        echo "TRACE45 $?"
# IceWarp default folders :
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
