#!/bin/bash
#
#	Choose among default backgrounds
#	or stored recent NASA backgrounds,
#	or type in a custom background path.
#
#	Author: 		Simon A. Erat (sea) <erat.simon AT gmail.com>
#	Created (y.m.d):	2012.10.24
#	Changed:		2015.03.08
#	License:		GPL v3
	script_version=0.4
#
#	Variables
#
	# Requires TUI
	
	defaultbg=$HOME/.config/awesome/img
	nasabg=$HOME/.backgrounds
	distrobg=/usr/share/backgrounds
	opt="--bg-fill"
	opt="--bg-scale"
	oPWD="$PWD"
	
	str_kind="Select kind of background:"
	str_bg="Select the actual background image:"
#
#	Outout
#	
	printf "\r\t\r" #;echo
	sleep 0.04
	tui-header "sea's Awesome WM" "Change BG"
	tui-title "$str_kind"
	style=menu
	while [ ! "$style" = Back ] 
	do	style=$(tui-select Back NASA-Random NASA Defaults Distro Custom)
		[ ! Back = "$style" ] && tui-title "$style"
		case "$style" in
		Back)		break		;;
		NASA-Random)	path=$nasabg
				cd "$path"
				max=$(ls -l|wc -l)
				num=$(rnd $max)
				files=( * )
				img="${files[$num]}"
				tui-echo "Selected random:" "$img"
				cd "$oPWD"
				;;
		NASA)		path=$nasabg	;;
		Distro)		path=$distrobg	;;
		Defaults)	path=$defaultbg ;;
		Custom) 	path=$(input "Please type the absolute path of the images:") ;;
		esac
		
		case "$style" in
		NASA-Random)	feh $opt "$path/$img"
				tui-echo
				;;
		*)		tui-echo "$str_bg"
				tui-echo "Images from path:" "$path"
				pics=$(cd "$path";ls;cd "$oPWD")
				img=todo
				while [ ! Back = "$img" ]
				do	img=$(tui-select Back $pics)
					[ $img = Back ] && break
					feh $opt "$path/$img"
					tui-status $? "Set background to: $img"
					tui-echo
					tui-title "$style"
					tui-echo "$str_bg" "or go Back"
				done
				;;
		esac
		tui-title "$str_kind"
		
		#tui-echo "$str_kind" "or go Back to exit."
	done
