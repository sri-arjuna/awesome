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
	#. tui
	img_url=""
	img_name=""
	rss=""
	RSS1="http://www.nasa.gov/rss/lg_image_of_the_day.rss"
	RSS2="http://www.nasa.gov/rss/dyn/image_of_the_day.rss"
	target=""
	FOLDER="$HOME/.backgrounds"
#
#	Display & Action
#

	# TITLE
	sleep 0.3
	tui-title "NASA - Image of the Day"
	#tui-echo " " "This script is not related with NASA"

	# Get Raw data
	tui-printf "Retrieving raw data (RSS)..." "$TUI_WAIT"
	rss=$(wget -q -O - "$RSS1")
	if tui-status $? "Retrieved raw data"
	then	echo "do nothing" > /dev/zero
	else	sh $(dirname $0)/changebg.sh << EOF
2
EOF
		fi

	# Prepare download
	img_url=$(echo $rss | grep -o '<enclosure [^>]*>' | grep -o 'http://[^\"]*')
	
	# change existing bg if no url was found
	if [[ -z "$img_url" ]]
	then	tui-status 1 "No URL could be identified, changing background to random image"
		sh $(dirname $0)/changebg.sh << EOF
2
EOF
		exit 1
	else	[[ -d "$FOLDER" ]] || mkdir -p "$FOLDER"
		img_url=$(echo $img_url|awk '{print $1}')
		tui-status $? "Found URL:" "$img_url"
		
		img_name=$(echo "$img_url" | grep -o [^/]*\.\w*$)
		tui-status $? "Selected image:" "$img_name"
		
		target="$FOLDER/$img_name"

		# Download the image
		#cd "$FOLDER"
		[ -f "${target:0:(-3)}jpg" ] 	|| tui-download $img_url
	
		# Converting to fixed size jpeg to save storage space
		tui-printf "Converting $img_name..." "$TUI_WORK"
		convert "$target" -resize 1920x1080 "${target:0:(-3)}jpg"
		tui-status $? "Converted ${target##*/}"
		target="${target:0:(-3)}jpg"
	
		# Set it as bg
		feh --bg-scale "$target"
		tui-wait 10s
	fi
