source /opt/icewarp/scripts/inc/functions.sh
trapExit() {
   exit 1
}
trap trapExit INT
/usr/bin/iconv -f ISO-8859-1 -t utf8 LICENSE "/opt/icewarp/licence/LICENSE" | /usr/bin/more
echo ""
good "You must accept this license agreement if you want to continue."
good "Press ENTER to accept license or CTRL+C to quit"
echo ""
read -s
mv /opt/icewarp/license/accept.sh /opt/icewarp/license/accepted.sh
trap INT
