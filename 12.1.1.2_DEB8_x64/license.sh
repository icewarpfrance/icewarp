#!/bin/bash
source /opt/icewarp/scripts/inc/functions.sh
trapExit() {
   stty sane
   exit 1
}
trap trapExit INT
/usr/bin/iconv -f ISO-8859-1 -t utf8 /opt/icewarp/license/LICENSE | /usr/bin/more
echo ""
good "You must accept this license agreement if you want to continue."
good "Press ENTER to accept license or CTRL+C to quit"
echo ""
read -s
trap INT
mv /opt/icewarp/license/license.sh /opt/icewarp/license/licenseAccepted.sh
exit 0
