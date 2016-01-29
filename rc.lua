-- ********************************************************************************
-- *** This Awesome 3.5 RC file was written in Jan 2016 by Simon Arjuna Erat	***
-- *** This configuration-structure is licensed as Create-Commons-by-SA 	***
-- *** For the latest version, check http://github.com/sri-arjuna/awesome	***
-- ********************************************************************************
--
--	Init Basic Libraries
--
	awful = require("awful")
	awful.rules = require("awful.rules")
	awful.util = require("awful.util")
	require("awful.autofocus")
	beautiful = require("beautiful")
	naughty = require("naughty")
	menubar = require("menubar")
	wibox = require("wibox")
	vicious = require("vicious")
--
--	Configuration : Variables
--
	theme = "sea"
	-- Hardware
	wifi = "wlp3s0"		-- The WIFI device to check
	modkey = "Mod4"		-- That is the Button with the Logo
-- 
-- 	Variables
--	For internal configuration use
--
	-- User dirs
	DIR_HOME        = os.getenv("HOME")
	DIR_PICTURES    = DIR_HOME .. "/mm/pics" -- os.getenv("XDG_PICTURES_DIR")
	DIR_MUSIC       = DIR_HOME .. "/mm/snds" -- os.getenv("XDG_MUSIC_DIR")
	DIR_BASE 	= awful.util.getdir("config")
	DIR_SHARED      = "/usr/share/awesome"
	-- Calculated dirs
	DIR_SHAREDTHEMES = DIR_SHARED .. "/themes"
	DIR_SCREENSHOTS = DIR_PICTURES .. "/Screenshots"
	DIR_WALLPAPER	= DIR_BASE .. "/img/wallpapers"
	DIR_THEMES	= DIR_BASE .. "/themes" 
	DIR_THEME	= DIR_THEMES .. "/" .. theme
	DIR_RC 		= DIR_BASE .. "/rc"
	DIR_SCRIPTS 	= DIR_BASE .. "/scripts"
	DIR_ICONS	= DIR_BASE .. "/img/icons"
	DIR_WIDGETS 	= DIR_RC .. "/widgets"
	-- Mouse coords
	capi = {
		mouse = mouse,
		screen = screen
	}
--
--	Functions
--
	beautiful.init( DIR_RC .. "/all-functions")
	dofile( DIR_RC .. "/config-apps")
	dofile( DIR_RC .. "/window-errors")
--
--	Theme & layouts
--
	beautiful.init( DIR_THEME .. "/theme.lua")
	-- Load 'distro specific' icon
	os_icon = wibox.widget.imagebox()
	os_icon:set_image( beautiful.icon_os )
--
-- 	Other designs...
--
	--layouts and screen names
	dofile ( DIR_RC .. "/window-layouts")
	-- menu
	dofile ( DIR_RC .. "/static-menu")
	-- taskbars / wibox
	dofile ( DIR_RC .. "/static-widget-all")
--
--	Hardware interactions
--
	dofile ( DIR_RC .. "/config-mouse")
	dofile ( DIR_RC .. "/config-hotkeys")
--
--	Rules to place apps
--	
	dofile ( DIR_RC .. "/window-rules")
	dofile ( DIR_RC .. "/window-signals")
--
-- 	Tasks on login
--
	-- Start these anyway
	awful.util.spawn_with_shell( "feh --bg-fill " .. beautiful.wallpaper .. " &")
	--awful.util.spawn_with_shell( term_cmd .. " sleep 5; exit" )
	-- Set IOTD and screensaver by default
	if true
	then
		awful.util.spawn_with_shell( "ps -x |grep -q [x]screensaver || xscreensaver &" )
		awful.util.spawn_with_shell( term_cmd .. "sleep;0.02 iotd")
		--awful.util.spawn_with_shell( "sleep 3; mpd ; sleep 1 ;mpc play")
	end
	-- Load 'basic workflow'
	if false		-- set false while testing
	then
		awful.util.spawn_with_shell( files )
		awful.util.spawn_with_shell( internet )
		awful.util.spawn_with_shell( editor )
		awful.util.spawn_with_shell( email )
		awful.util.spawn_with_shell( irc )
		awful.util.spawn_with_shell( torrent )
	end
