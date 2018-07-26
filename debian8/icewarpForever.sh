#!/bin/bash
set -e
stopIceWarpService()
{
   /usr/sbin/service icewarp stop
   exitStatus=$?
   /bin/kill -TERM "${childPid}" 2>/dev/null
   exit $exitStatus
}
if test -f /opt/icewarp/calendar.tgz
then
   /bin/chown icewarp:icewarp /opt/icewarp/config
   /bin/chown icewarp:icewarp /opt/icewarp/mail
   /bin/chown icewarp:icewarp /opt/icewarp/logs
   /bin/chown icewarp:icewarp /opt/icewarp/temp
   /bin/chown icewarp:icewarp /opt/icewarp/spam
   /bin/chown icewarp:icewarp /opt/icewarp/calendar
   cd /opt/icewarp
   /bin/tar xzf calendar.tgz calendar/
   /bin/tar xzf spam.tgz     spam/
   /bin/tar xzf config.tgz   config/
   /bin/rm calendar.tgz spam.tgz config.tgz
   if test -z "$PUBLICIP"
   then
      PUBLICIP=`wget http://ipecho.net/plain -O - -q`
   fi
   if test -z "$LOCALIP"
   then
      LOCALIP=`ip -o -4 a s eth0 | awk '{sub(/\/.*/, "", $4);print $4}'`
   fi
   if test -z "$DNSSERVER"
   then
      DNSSERVER=`grep -i '^nameserver' /etc/resolv.conf |head -n1|cut -d ' ' -f2`
   fi
   /opt/icewarp/tool.sh set system  c_system_services_sip_localaccesshost  $LOCALIP
   /opt/icewarp/tool.sh set system  c_system_services_sip_remoteaccesshost $PUBLICIP
   /opt/icewarp/tool.sh set system  c_mail_smtp_general_dnsserver          $DNSSERVER
fi
/usr/sbin/service icewarp start
trap stopIceWarpService TERM
/bin/sleep infinity &
childPid=$!
wait ${childPid}
trap - TERM
wait ${childPid}
