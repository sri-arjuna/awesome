#!/bin/bash
 
# grabs the nasa image of the day by RSS feed and updates the gnome
# background. add this to your cron jobs to have this happen daily.  this is,
# obviously, a hack, that is likely to break at the slightest change of NASA's
# RSS implementation. yay standards!
#
#	Variables
#
	[ -z $WORK ] && . tui
	nasa_dir=$HOME/.backgrounds/
#
#EDITED FOR feh


tui-title "NASA Image of the Day"
# Get Feed
	sleep 0.01
	tui-printf "Retreiving RSS Feed..." "$WORK"
	sleep 0.2
	rss=`wget -q -O - http://www.nasa.gov/rss/lg_image_of_the_day.rss`
	tui-status $? "Retrieved RSS Feed"
	# Save for analyze
	echo "$RSS" > $HOME/data/iotd.txt
# Get Picture
	tui-printf "Parsing for picture..." "$WORK"
	img_url=`echo $rss | grep -o '<enclosure [^>]*>' | grep -o 'http://[^\"]*'`
	#tui-status $? "Found image $img_url"

	img_name=`echo $img_url | grep -o [^/]*\.\w*$`
	#[ ! -z $img_name ] && OF="$nasa_dir/$img_name" || OF=""
	OF="$nasa_dir/$img_name"
	tui-status $? "Saving to $OF"
	tui-bol-dir "$nasa_dir"
	#mkdir -p $HOME/.backgrounds
# Download 
	if [ ! -f "$OF" ]
	then 	#cd "$nasa_dir" && tui-download "$img_url"
		wget -q -O "$OF" "$img_url"
	fi
# Change BG
	tui-printf "Changing the background" "$WORK"
	feh --bg-scale "$OF"
	tui-status $? "Changed background to $OF"
	sleep 5
