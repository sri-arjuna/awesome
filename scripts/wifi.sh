#!/usr/bin/bash
# Simple script to get either AP-name or signal strength for wifi

OUT=""
WIFI=$(ip addr | awk '{print $2}'|grep ^w)
WIFI=${WIFI/:}

[ -z "$1" ] && echo "Usage: wifi.sh ap|signal" && exit 1
[ -z "$WIFI" ] && echo "No wifi device found!" && exit 1


echo TODO?, does not seem required.. i have the info on ARCH linux...
exit

case "$1" in	 ;;
ap)		acpi | awk -v IFS="," '{print $4}' | tr -d ','	;;
signal)		acpi | awk -v IFS="," '{print $5}' | tr -d ','	;;
esac

if [ ! -z "$OUT" ]
then	if [ ${OUT/\%} -lt 10 ]
	then	tmp="$HOME/.cache/warning.sh"
		echo "tui-typewriter -d 0.08 'Connect your power cable, you got only ${OUT}% power left!';tui-wait 5m" > "$tmp"
		tui-terminal "bash $tmp"
		cat "$tmp"
	fi
	echo "$OUT"
fi
