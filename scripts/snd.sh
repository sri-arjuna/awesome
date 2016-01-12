#!/usr/bin/bash
# Simple script to get either time or percentage remaining of battery
# Includes a warning to the user if percentage is below 10.
# Requires amixer, and maybe later: https://github.com/davidbrazdil/volnoti/issues
# Images from: 'batterymon-themer.sh' from an icon pack.
[ -z "$1" ] && echo "Usage: snd.sh [image|mute|vol] up|down [INTERVALL=5]" && exit 1
#
#	Variables
#
	DEVICE=Master	# or : Capture
	CARDID=0
	waychar=""	# + / -
	MODE=$1
	INTERVALL=${2:-3}
	DATA_RAW=$(LC_ALL=C amixer get $DEVICE)
	echo "$DATA_RAW" | grep -q -i "\[off\]" && isMute=true || isMute=false
	$isMute && IMAGE=inactive || IMAGE=norm
#
#	Functions
#
	vol.cur() { echo "$DATA_RAW" | awk  '/ft: Playback/ {print $5}'|tr -d '[]' ; }
	vol.chg() { amixer -c $CARDID set ${DEVICE} ${INTERVALL}dB${waychar} ; }
	vol.toggle() { (amixer get Master | grep -q off && amixer -q set $DEVICE unmute) || amixer -q set $DEVICE mute ; }
#
#	Prepare
#
	VOL=$(vol.cur)
	case "$MODE" in
	down)	waychar="-"	;;
	up)	waychar="+"	;;
	mute)	vol.toggle
		exit $? 	;;
	vol)	echo $VOL
		exit $?		;;
	esac
#
#	Action
#
	case "$MODE" in
	down|up)
		vol.chg
		exit $?
		;;
	image)	VOL=${VOL/\%}
		if [ ${#VOL} -le 1 ]
		then 	N=1
		elif [ ${#VOL} -eq 3 ]
		then 	N=${VOL:0:2}
		else	N=${VOL:0:1}
		fi
		echo "$IMAGE$N.png"
		;;
	esac
