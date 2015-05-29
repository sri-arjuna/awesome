#!/bin/bash
 
# grabs the nasa image of the day by RSS feed and updates the gnome
# background. add this to your cron jobs to have this happen daily.  this is,
# obviously, a hack, that is likely to break at the slightest change of NASA's
# RSS implementation. yay standards!

#EDITED FOR feh
#EDITED FOR tui

#
#	Variables
#
	img_url=""
	img_name=""
	rss=""
	RSS1="http://www.nasa.gov/rss/lg_image_of_the_day.rss"
	RSS2="http://www.nasa.gov/rss/dyn/image_of_the_day.rss"
	target=""
	FOLDER="$HOME/.backgrounds"
	WAIT=3
#
#	Display & Action
#

	# TITLE
	sleep 0.5
	tui-title "NASA - Image of the Day"
	tui-echo " " "This script is not related with NASA"
	
	RET=-1
	for R in "$RSS1" "$RSS2";do
		# Get Raw data
		tui-status -r 2 "Retrieving raw data ($R)..."
		rss=$(wget -q -O - "$R")
		[ ! -z "$rss" ]
		if tui-status $? "Retrieved raw data"
		then	# It has data, but can it find a recent image?
			img_url=$(echo $rss | grep -o '<enclosure [^>]*>' | grep -o 'http://[^\"]*')
			[ ! -z "$img_url" ] && \
				RET=0 && \
				break
		fi
	done
	
	# Prepare download
	#img_url=$(echo $rss | grep -o '<enclosure [^>]*>' | grep -o 'http://[^\"]*')
	
	# change existing bg if no url was found
	if [ -z "$img_url" ] || [ 0 -ne $RET ]
	then	tui-status 1 "No URL could be identified, changing background to random image"
		tui-wait $WAIT "Changing to random wallpaper"
		sh $(dirname $0)/changebg.sh << EOF
2
1
EOF
		tui-status $? "Changed wallpaper"
		sleep 3 ; exit 1
	else	[ -d "$FOLDER" ] || mkdir -p "$FOLDER"
	
		img_url=$(echo $img_url|awk '{print $1}')
		tui-status $? "Found URL:" "$img_url"
	
		
		img_name=$(echo "$img_url" | grep -o [^/]*\.\w*$ )
		target="$(date +'%F')_${img_name/\?*/}"
		target="${target:0:(-3)}jpg"
		tui-status $? "Selected image:" "$img_name"
		
		# Download the image
		cd "$FOLDER"
		if [ ! -f "$img_name" ] && [ ! -f "$target" ]
		then	# Requires to become downloaded
			tui-download "$img_url"
			
			# Rename to list in date order
			mv "$img_name" "$target"
			tui-status $? "Renamed to" "$target"
			
			# Converting to fixed size jpeg to save storage space
			tui-printf "Converting $img_name..." "$TUI_WORK"
			convert "$target" -resize $(xrandr | awk '/\*/ {print $1}') "$target"
			tui-status $? "Converted ${target##*/}"
		fi
		target="${target:0:(-3)}jpg"
		
		# Set it as bg
		feh --bg-scale "$target"
		tui-status $? "Changed background to $target"
		cd "$OLDPWD"
		tui-wait $(( 2 * $WAIT ))
		exit 0
	fi
	sleep 1