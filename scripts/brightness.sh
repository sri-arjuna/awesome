#!/usr/bin/env  bash
# Description:	Change brightness of laptop lcd
#		This script is part of my AwesomeWM configuration (https://github.com/sri-arjuna/awesome)
#		The most recent version should be available on: https://raw.githubusercontent.com/sri-arjuna/awesome/master/scripts/brightness.sh
# Disclaimer:	This code comes without any warrenty of any kind, use at your own risk!
# GNU General Public License (GPL) 2016 by Simon Arjuna Erat (sea) (erat.simon æ gmail,com)
#
# 
#	Variables
#
	#set -x
	BASE=/sys/class/backlight
	ITEM=$(cd $BASE;ls)
	DIR=$BASE/$ITEM
	FILE=$DIR/brightness #backlight
	MAX=$(<$DIR/max_brightness)
	STEP_COUNT=20
	STEP_VALUE=$(( $MAX / $STEP_COUNT ))
	CUR=$(<$FILE)
	DISPLAY=$(xrandr | grep -B5 '*'|awk '/ connected/ {print $1}')
	#set +x
	#echo $DISPLAY ; exit 5
# 
#	Action
#
	if which xbacklight 2>/dev/null 1>&2
	then	# xbacklight is installed
		thisDisplay="-display $DISPLAY"
		thisDisplay=""
		case "${1,,}" in
		"")	echo "Usage: brightness.sh up|down"
			exit 1
			;;
		up)	#(set -x;
			xbacklight $thisDisplay -inc 10 
			# )
			;;
		down)	#(set -x;
			xbacklight $thisDisplay -dec 10
			# )
			;;
		esac
	else	# Fallback, dont like the use of sudo in a background script
		# Required/recomend passwordless sudo, but is a security risk!
		case "${1,,}" in
		"")	echo "Usage: brightness.sh up|down"
			exit 1
			;;
		up)	num=$(( $CUR + $STEP_VALUE ))
			[ $num -ge $MAX ] && num=$MAX
			[ $num -le 0 ] && num=0
			sudo tee $FILE <<< $num
			;;
		down)
			num=$(( $CUR - $STEP_VALUE ))
			[ $num -ge $MAX ] && num=$MAX
			[ $num -le 0 ] && num=0
			sudo tee $FILE <<< $num
			;;
		esac
	fi
