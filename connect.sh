#!/bin/bash

tm="$(date +%s)"
dt="$(date +'%Y-%m-%d %H:%M:%S')"
timestamp="$(date +'%FT%TZ')"

. /etc/openvpn/script/config.sh

##set status online to user connected
bandwidth_check=`mysql -u $USER -p$PASS -D $DB -h $HOST --skip-column-names -e "SELECT bandwidth_logs.username FROM bandwidth_logs WHERE bandwidth_logs.username='$common_name' AND bandwidth_logs.category='#cat#' AND bandwidth_logs.status='online'"`
if [ "$bandwidth_check" == 1 ]; then
mysql -u $USER -p$PASS -D $DB -h $HOST -e "UPDATE bandwith_logs SET server_ip='$local_1', server_port='$trusted_port', timestamp='$timestamp', ipaddress='$trusted_ip:$trusted_port', username='$common_name', time_in='$tm', since_connected='$time_ascii', bytes_received='$bytes_received', bytes_sent='$bytes_sent' WHERE username='$common_name' AND status='online' AND category='#cat#' "
mysql -u $USER -p$PASS -D $DB -h $HOST -e "UPDATE users SET is_connected=1 WHERE user_name='$common_name' "
else
mysql -u $USER -p$PASS -D $DB -h $HOST -e "INSERT INTO bandwidth_logs (server_ip, server_port, timestamp, ipaddress, since_connected, username, bytes_received, bytes_sent, time_in, status, time, category) VALUES ('$local_1','$trusted_port','$timestamp','$trusted_ip:$trusted_port','$time_ascii','$common_name','$bytes_received','$bytes_sent','$dt','online','$tm','#cat#') "
mysql -u $USER -p$PASS -D $DB -h $HOST -e "UPDATE users SET device_connected=1, is_connected=1 WHERE user_name='$common_name' "
fi
