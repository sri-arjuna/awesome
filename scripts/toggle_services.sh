#!/usr/bin/env bash
# Take a breath
	sleep 0.5
	WAIT=2
	KNOWN="dkms bluetooth cups mpd httpd sendmail"
	help_text="Usage: ${0##*/} start|stop|status SERVICE[.service]"
	TMP=$HOME/.cache/$$.tmp
# Check first argument
	case "${1,,}" in
	-h|--help|"")
		echo "$help_text"
		exit 99
		;;
	start)	mode=start	;;
	stop)	mode=stop	;;
	status)	mode=status	;;
	*)	tui-status 1 "Unkown mode: $mode"
		tui-wait $WAIT "Closing in..."
		exit $?
		;;
	esac
# Get the action
	if ! tui-bol-root # && \
	then	tui-print -S 1 "Requires root access." # && \
		if tui-yesno "Start as root now?" # && \
		then	tui-asroot "$0 $@" || systemctl status 
			RET=$?
			tui-press
			exit $RET
		else	exit 1
		fi
	fi
# User is root
	[ $# -lt 1 ] && \
		tui-print -S 1 "$help_text" && \
		sleep 5 && \
		exit 1
# Check second argument if applicable
	if [ $# -lt 2 ] && [ ! status = $mode ]
	then	tui-echo "Which service to $mode?"
		service=$(tui-select $KNOWN other)
		[ other = "$service" ] && \
			service=$(tui-read "Please name the service you want to $mode:")
		service="${service/.service/}.service"
	elif [ ! status = $mode ]
	then	service="${2/.service/}.service"
	else 	# Just show the status
		systemctl $mode
		exit $?
	fi
	echo "systemctl $mode ${service}" > "$TMP"
# Execute the command / Display
#set -x
	tui-title "${mode^} : ${service^}"
	tui-bgjob "$TMP" "${mode^}ing $service..." "${mode^}ed $service..." && \
		#	tui-yesno "Disable the service of \"$service\" as well?" && \
		#	systemctl disable $service 2>/dev/zero && \
			RET=0 || RET=1
	# As all start with 'st' lets compare letters 3+4.
	case "${mode:2:2}" in
	ar|op)	tui-wait $WAIT "Closing in..."
		;;
	at)	tui-press
		;;
	*)	tui-status 1 "Could not handle mode: $mode"
		RET=1
		tui-wait $WAIT "Closing in..."
		;;
	esac
#set +x
exit ${RET:-1}
