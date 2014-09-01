#!/bin/bash
#
#	Choose among default backgrounds
#	or stored recent NASA backgrounds,
#	or type in a custom background path.
#
#	Author: 		Simon A. Erat (sea) <erat.simon AT gmail.com>
#	Created (y.m.d):	2012.10.24
#	Changed:		2014.08.31
#	License:		GPL v3
	script_version=0.3
#
#	Variables
#
	# Requires TUI
	
	defaultbg=$HOME/.config/awesome/img
	nasabg=$HOME/.backgrounds
	distrobg=/usr/share/backgrounds
	opt="--bg-fill"
	opt="--bg-scale"
	
	
	str_kind="Select kind of background:"
	str_bg="Select the actual background image:"
#
#	Outout
#	
	printf "\r\t\r" #;echo
	sleep 0.01
	tui-header "sea's Awesome WM" "Change BG"
	tui-title "$str_kind"
	select style in Back NASA-Random NASA Defaults Distro Custom
	do	case $style in
		Back)		break		;;
		NASA-Random)	path=$nasabg
				cd $path
				max=$(ls -l|wc -l)
				num=$(rnd $max)
				files=( * )
				img="${files[$num]}"
				;;
		NASA)		path=$nasabg	;;
		Distro)		path=$distrobg	;;
		Defaults)	path=$defaultbg ;;
		Custom) 	path=$(input "Please type the absolute path of the images:") ;;
		esac
		
		case $style in
		NASA-Random)	feh $opt "$path/$img"
				;;
		*)		tui-title "$str_bg"
				tui-echo "$style" "$path"
				pics=$(cd $path;ls $path)
				select img in Back $pics
				do	[ $img = Back ] && break
					feh $opt "$path/$img"
					tui-echo "$str_bg" "or go Back"
				done
				;;
		esac
		tui-echo "$str_kind" "or go Back to exit."
	done
