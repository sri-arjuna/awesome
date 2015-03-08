#!/usr/bin/env bash
# Take a breath
	sleep 0.5
	KNOWN="bluetooth cups httpd sendmail"
	TMP=$HOME/.cache/$$.tmp
# Get the action
	[ $# -lt 1 ] && \
		tui-printf -S 1 "Usage: toggle_service.sh start|stop service[.service]" && \
		sleep 5 && \
		exit 1
# Check first argument
	case "${1,,}" in
	start)	mode=start	;;
	stop)	mode=stop	;;
	status)	mode=status	;;
	*)	tui-status 1 "Unkown mode: $mode"
		tui-wait 4 "Closing in..."
		exit $?
		;;
	esac
# Check second argument if applicable
	if [ $# -lt 2 ] && [ ! status = $mode ]
	then	tui-echo "Which service to $mode?"
		service=$(tui-select $KNOWN other)
		[ other = $service ] && \
			service=$(tui-read "Please name the service you want to $mode:")
		service="${service/.service/}.service"
	elif [ ! status = $mode ]
	then	service="${2/.service/}.service"
	else 	# Just show the status
		sudo systemctl $mode
		exit
	fi
	echo "sudo systemctl $mode ${service}" > $TMP
# Execute the command / Display
	tui-title "${mode^} : ${service^}"
	tui-bgjob "$TMP" "${mode^}ing $service..." "${mode^}ed $service..." && \
			tui-yesno "Disable the service of \"$service\" as well?" && \
			sudo systemctl disable $service 2>/dev/zero
	
	case "${mode:2:2}" in
	ar|op)	tui-wait 3 "Closing in..."
		;;
	at)	tui-press
		;;
	*)	tui-status 1 "Could not handle mode: $mode"
		tui-wait 3 "Closing in..."
		;;
	esac
exit 0