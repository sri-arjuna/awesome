#!/usr/bin/env bash
tui-title "Power menu for $HOSTNAME"
task_list="Cancel Hibernate Reboot Shutdown Suspend"
task=$(tui-select -1 $task_list)
case ${task,,} in
cancel)		exit 0		;;
hibernate)	pm-hibernate	;;
reboot)		reboot		;;
shutdown)	systemctl isolate poweroff.target
		;;
Suspend)	pm-suspend
		exit $?
		;;
esac