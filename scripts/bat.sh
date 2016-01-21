#!/usr/bin/bash
# Simple script to get either time or percentage remaining of battery
# Includes a warning to the user if percentage is below 10.
# Requires acpi & tui (for the warning of powerloss/drain)
# Images from: 'batterymon-themer.sh' from an icon pack.
#
#	Variables
#
	[ -z "$1" ] && echo "Usage: bat.sh percent|time|image" && exit 1
	OUT=""
	IMAGE="battery"
	DATA_RAW=$(LC_ALL=C acpi)
	mode=$(echo "$DATA_RAW" | awk -v IFS="," '{print $3}' | tr -d ',')
	[ -z "${mode/Charging}" ] && prefix="+" || prefix="-"
#
#	Time
#
	[ "$1" = "time" ] && echo "$DATA_RAW" | awk -v PRE=$prefix -v IFS="," '{print PRE$5}' | tr -d ',' && exit 0
#
#	Percent
#
	OUT=$(echo "$DATA_RAW" | awk -v IFS="," '{print $4}' | tr -d ',')
	if [ "$1" = "percent" ]
	then	if [ ${OUT/\%} -lt 10 ]
		then	#tmp="$HOME/.cache/warning.sh"
			#echo "tui-print; printf '\r\';tui-typewriter -d 0.08 'Connect your power cable, you got only ${OUT}% power left!';tui-wait 5m" > "$tmp"
			#chmod +x "$tmp"
			#tui-bol-gui && { tui-terminal "$tmp"  || bash "$tmp" ; }
			echo "msgbox(\"Connect Power Cord!\")" | awesome-client
		fi
		echo "${prefix/-}$OUT"
		exit 0
	fi
#
# 	Image
#
	OUT="${OUT/\%}"
	[ "$mode" = "Charging" ] && IMAGE+="_${mode,,}"
	if [ $OUT -lt 20 ]
	then	N=1
	elif [ $OUT -lt 40 ]
	then	N=2
	elif [ $OUT -lt 60 ]
	then	N=3
	elif [ $OUT -lt 80 ]
	then	N=4
	elif [ $OUT -lt 100 ]
	then	N=5
	elif echo "$DATA_RAW" | grep -q "discharging at zero rate"
	then	N="full"
	#else	tui-bol-gui && tui-terminal "tui-header;echo $OUT;tui-press" &
	fi
	IMAGE+="_$N.png"
	echo "$IMAGE"
	exit 0
