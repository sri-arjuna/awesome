#!/bin/bash
# Change brightness of laptop lcd
# 
#	Variables
#
	if which xbacklight 2>/dev/null >&2
	then	# xbacklight is installed
		#cur=$(xbacklight)
		#cur=${cur/\.*}
		case "${1,,}" in
		"")	echo "Usage: brightness.sh up|down"
			exit 1
			;;
		up)	xbacklight -inc 20
			;;
		down)	xbacklight -dec 20
			;;
		esac
	else	# Fallback, dont like the use of sudo in a background script
		# Required/recomend passwordless sudo, but is a security risk!
		BASE=/sys/class/backlight
		ITEM=$(cd $BASE;ls)
		DIR=$BASE/$ITEM
		FILE=$DIR/backlight
		MAX=$(<$DIR/max_backlight)
		STEP_COUNT=20
		STEP_VALUE=$(( $MAX / $STEP_COUNT ))
		CUR=$(<$FILE)
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
