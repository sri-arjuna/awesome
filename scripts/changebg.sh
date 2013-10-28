#!/bin/bash
#
#	Choose among default backgrounds
#	or stored recent NASA backgrounds,
#	or type in a custom background path.
#
#	Author: 		Simon A. Erat (sea) <erat.simon AT gmail.com>
#	Created (y.m.d):	2012.10.24
#	Changed:		2013.10.26
#	License:		GPL v3
	script_version=0.3
#
#	Variables
#
	#stconf=/usr/share/script-tools/st.cfg
	#[ ! -f $stconf ] && \
	#	echo "This script was written for the sea-Awesome-WM compilation." && \
	#	echo "Therefor it requires sea's Script-Tools." && \
	#	echo "Please have a look at: http://sea.hostingsociety.com/?p=Script-Tools" && \
	#	exit 1 || \
	#	source $stconf
	
	defaultbg=$HOME/.config/awesome/img
	nasabg=$HOME/.backgrounds
	
	str_kind="Select kind of background:"
	str_bg="Select the actual background image:"
#
#	Outout
#	
	printf "\r\t\r";echo
	tui-header "sea's Awesome WM" "Change BG"
	tui-title "$str_kind"
	select style in Back NASA Defaults Custom
	do	case $style in
		Back)		break		;;
		NASA)		path=$nasabg	;;
		Defaults)	path=$defaultbg ;;
		Custom) 	path=$(input "Please type the absolute path of the images:") ;;
		esac
		
		tui-title "$str_bg"
		tui-echo "$style" "$path"
		pics=$(cd $path;ls $path)
		select img in Back $pics
		do	[ $img = Back ] && break
			feh --bg-scale $path/$img
			tui-echo "$str_bg" "or go Back"
		done
	
		tui-echo "$str_kind" "or go Back to exit."
	done
