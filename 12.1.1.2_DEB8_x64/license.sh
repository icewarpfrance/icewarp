source /opt/icewarp/scripts/inc/functions.sh
trapExit() {
   exit 1
}
trap trapExit INT
more "/opt/icewarp/licences/LICENSE"
echo ""
good "You must accept this license agreement if you want to continue."
good "Press ENTER to accept license or CTRL+C to quit"
echo ""
read -s
mv /opt/icewarp/licenses/accept.sh /opt/icewarp/licenses/accepted.sh
trap INT
