#!/bin/bash
set -e
stopIceWarpService()
{
   /opt/icewarp/icewarpd.sh --stop
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
      LOCALIP=$(hostname -I)
   fi
   if test -z "$DNSSERVER"
   then
      DNSSERVER=`grep -i '^nameserver' /etc/resolv.conf |head -n1|cut -d ' ' -f2`
   fi
   /opt/icewarp/tool.sh set system  c_system_services_sip_localaccesshost  $LOCALIP
   /opt/icewarp/tool.sh set system  c_system_services_sip_remoteaccesshost $PUBLICIP
   /opt/icewarp/tool.sh set system  c_mail_smtp_general_dnsserver          $DNSSERVER
   /opt/icewarp/tool.sh set system  C_Meeting_Active                       1
fi
/opt/icewarp/icewarpd.sh --start
trap stopIceWarpService TERM
/bin/sleep infinity &
childPid=$!
wait ${childPid}
trap - TERM
wait ${childPid}
