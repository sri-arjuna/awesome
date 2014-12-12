#!/bin/bash
 
# grabs the nasa image of the day by RSS feed and updates the gnome
# background. add this to your cron jobs to have this happen daily.  this is,
# obviously, a hack, that is likely to break at the slightest change of NASA's
# RSS implementation. yay standards!
#
#	Variables
#
	[ -z $TUI_WORK ] && . tui
	nasa_dir=$HOME/.backgrounds
	DEBUG=false
#
#EDITED FOR feh

	$DEBUG && set -x
	sleep 0.1
	tui-title "NASA Image of the Day" ; printf "$TUI_RESET"
# Get Feed
	sleep 0.01
	tui-printf "Retreiving RSS Feed..." "$TUI_WORK"
	sleep 0.2
	$DEBUG && set +x
	#rss=`wget -q -O - http://www.nasa.gov/rss/lg_image_of_the_day.rss`
	rss=`wget -q -O - http://www.nasa.gov/rss/dyn/image_of_the_day.rss`
	tui-status $? "Retrieved RSS Feed" || exit 1
	$DEBUG && set -x
	# Save for analyze
	#echo "$rss" > $HOME/data/iotd.txt
# Get Picture
	tui-printf "Parsing for picture..." "$TUI_WORK"
	#img_url=`echo $rss | grep -o '<enclosure [^>]*>' | grep -o 'http://[^\"]*'`
	img_url=`echo $rss | grep -o '<enclosure [^>]*>' | grep -o 'http://[^\"]*'`
	#img_name=`echo $img_url | grep -o [^/]*\.\w*$`
	img_name=`echo $img_url | grep -o [^/]*\.\w*$`
	tui-status $? "Found to \"$img_name\"" || exit 1
	OF="$nasa_dir/$img_name"
	#tui-bol-dir "$nasa_dir" #&& cd "$nasa_dir"
	[[ -d "$nasa_dir" ]] || mkdir -p "$nasa_dir"
# DEBUG
	if $DEBUG
	then	tui-title "DEBUG INFO"
		tui-echo "img_url:" 	"$img_url"
		tui-echo "img_name:"	"$img_name"
		tui-echo "nasa_dir:"	"$nasa_dir"
		tui-echo "OF:"		"$OF"
	fi
# Verify proper filename
	echo "$OF"|grep -q '?' && \
		OF=$(echo "$OF"|sed s,?.*,'',g)
	
# Download 
	if [ ! -f "$OF" ]
	then 	#cd "$nasa_dir" && tui-download "$img_url"
		wget -q -O "$OF" "$img_url"
	fi
# Change BG
	tui-printf "Changing the background" "$TUI_WORK"
	[[ -f "$OF" ]] && \
		feh --bg-scale "$OF" || \
		tui-echo "Failed"
	tui-status $? "Changed background to $OF"
	sleep 5
