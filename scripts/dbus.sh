#!/usr/bin/env bash
case "${1,,}" in
suspend|hibernate)
	dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.${1^}
	;;
restart|stop)
	dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.${1^}
	;;
*)	echo "Usage: ${0##*/} suspend|hibernate|restart|stop"
	exit 1
	;;
esac
