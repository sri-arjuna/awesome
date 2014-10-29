-- Standard awesome library
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
--FreeDesktop -- TAKES AGES TO LOAD ~~ 5-9 secs ! __ and without less dependencies
--require('freedesktop.utils')
--require('freedesktop.menu')
--freedesktop.utils.icon_theme = 'tango'
--Vicious + Widgets 
vicious = require("vicious")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
naughty = require("naughty")
local menubar = require("menubar")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
	if awesome.startup_errors then
	    naughty.notify({ preset = naughty.config.presets.critical,
		             title = "Oops, there were errors during startup!",
		             text = awesome.startup_errors })
	end

	-- Handle runtime errors after startup
	do
	    local in_error = false
	    awesome.connect_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({ preset = naughty.config.presets.critical,
		                 title = "Oops, an error happened!",
		                 text = err })
		in_error = false
	    end)
	end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
	--beautiful.init("/usr/share/awesome/themes/gray/theme.lua")
	beautiful.init(awful.util.getdir("config") .. "/themes/sea/theme.lua")

-- This is used later as the default terminal and editor to run.
	terminal = "lxterminal"
	term_cmd = terminal .. " -e "
	editor = os.getenv("EDITOR") or "pluma"
	editor_cmd = terminal .. " -e " .. editor
-- Wifi
	wifi = "wlp3s0"
-- Apps
	internet = "firefox"
	irc = "xchat"
	files = "pcmanfm"
	ftp = "filezilla"
	email = "thunderbird"
	video = "vlc"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
	modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
	local layouts =
	{
	    awful.layout.suit.floating,
	    awful.layout.suit.tile,
	    awful.layout.suit.tile.left,
	    awful.layout.suit.tile.bottom,
	    awful.layout.suit.tile.top,
	    awful.layout.suit.fair,
	    awful.layout.suit.fair.horizontal,
	    awful.layout.suit.spiral,
	    awful.layout.suit.spiral.dwindle,
	    awful.layout.suit.max,
	    awful.layout.suit.max.fullscreen,
	    awful.layout.suit.magnifier
	}
-- }}}

-- {{{ Wallpaper
--	if beautiful.wallpaper then
--	    for s = 1, screen.count() do
--		gears.wallpaper.maximized(beautiful.wallpaper, s, true)
--	    end
--	end
-- }}}

-- Define a tag table which hold all screen tags.
	tags = { }
	tags = {
	    names = { "ॐ", "∞",  "இ", "ห",   "ت", "⌥", "ℵ", "⌤", "∴" },
	    -- ∀  φ ‡ இ  ∞ ت ξ گ ห ⚡   "⌥",  "ℵ", "⌤", "∴"  
	    -- layout 10-fenster ; 
	    layout = { layouts[6], layouts[6], layouts[12], layouts[6], layouts[6], layouts[2], layouts[2], layouts[2], layouts[2] }
	}

	for s = 1, screen.count() do
	    -- Each screen has its own tag table.
	    tags[s] = awful.tag(tags.names, s, tags.layout)
	end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
	mnuGraph = {
		{ "gimp", "gimp" },
		{ "mtPaint", "mtpaint" },
	}
	mnuMM = {
		{ "DeVeDe", "devede", },
		{ "music", "rhythmbox", },
		{ "Record-Desktop", terminal .. " -e vhs -S", },
		{ "Record-Guide", terminal .. " -e vhs -G", },
		{ "Record-Webcam", terminal .. " -e vhs -W", },
		{ "Stop-Recording", terminal .. " -e vhs -K", },
	--	{ "Stop-Recording2", terminal .. " -e pkill $(ps -ha|grep bgjob|grep -v grep|awk '{print $1}')", },
		{ "video", video, },
		{ "volume", terminal .. " -e alsamixer", },
	}
	mnuOffice = {
		{ "letters", "abiword" },
		{ "sheets", "gnumeric" },
	}
	mytools = {
		{ "calculator", "galculator", },
		{ "browser", internet },
		{ "editor", editor },
		{ "email", email },
		{ "files", files },
		{ "ftp", ftp },
		{ "irc", irc },
		{ "torrents", "transmission-gtk" },
		{ "virtualbox", "virtualbox" },
	}
	mnuRecovery = {
		{ "efi-helper", terminal .. " -e sudo efi-helper" },
		{ "Rebuild dracut", terminal .. " -e sudo dracut-rebuild" },
		{ "mount partitions", terminal .. " -e sudo moalpa" },
		
	--	{ "", "" },
	--	{ "", "" },
	--	{ "", "" },
	}
	
	menusystem = {
	    { "Date & Time", "system-config-date" },
	    { "Firewall", "system-config-firewall" },
	    { "Keyboard", "system-config-keyboard" },
	    { "Language", "system-config-language" },
	    { "Partitions", "gnome-disk-utility" },
	    { "Users", "system-config-users" },
	    { "Screensaver", "xscreensaver-demo" },
	    { "Services", "system-config-services" },
	    { "Task Manager", "lxtask" },
	    --{ "Wireless", "wicd-curses" },
	    { "Wireless", "nm-connection-editor" },
	    { "Yum Extender", "yumex" }
	}
	menuscripttools = {
	    { "Main Menu", terminal .. " -e st" },
	    { "iso to usb", terminal .. " -e st iso usb" },
	    { "dl YT vids", terminal .. " -e st net yt" },
	    { "dl Fedora iso", terminal .. " -e st net dl-fed" },
	    { "Grub2 themes", terminal .. " -e sudo st tweak grub2 theme change" },
	    { "Plymouth", terminal .. " -e sudo st tweak plymouth" },
	    { "Change PS1", terminal .. " -e st tweak ps1" },
	    { "------",},
	    { "open projects", files .. "$XDG_PROJECT_DIR" },
	}
	mnuPower = {
		{ 'suspend',   'dbus-send --system --print-reply --dest="org.freedesktop.UPower"     /org/freedesktop/UPower org.freedesktop.UPower.Suspend' },
		{ 'hibernate', 'dbus-send --system --print-reply --dest="org.freedesktop.UPower"     /org/freedesktop/UPower org.freedesktop.UPower.Hibernate' },
		{ 'reboot',    'dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart', }, --beautiful.reload_icon },
		{ 'halt',      'dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop' },
		{ "logout", awesome.quit }
	}
	myawesomemenu = {
	   { "edit config", editor .. " " .. awesome.conffile },
	   { "edit tui cfg", editor .. " .config/tui/apps.conf .config/tui/user.conf" },
	   { "manual", terminal .. " -e man awesome" },
	   { "BG: NASA iotd", term_cmd .. awful.util.getdir("config") .. "/scripts/nasaBackground-new.sh",  },
	   { "BG: Change", term_cmd .. awful.util.getdir("config") .. "/scripts/changebg.sh",  },
	   { "restart cfg", awesome.restart },
	   { "quit", awesome.quit },
	}
	mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
		                            { "system config", menusystem, beautiful.fedora_icon},
	   				    { "applications", mytools,},
	   				    { "multimedia", mnuMM, },
					    { "graphics", mnuGraph, },
					    { "office", mnuOffice, },
					    { "recovery", mnuRecovery, },
					    { "power", mnuPower, }, --beautiful.power_icon } ,
		                         --   { "Script-Tools", menuscripttools, }, --beautiful.fedora_icon },
		                            { "open terminal", terminal }
		                          }
		                })

	fedora_icon = wibox.widget.imagebox()
	fedora_icon:set_image("/etc/favicon.png")
	
	--fedora = wibox.widget.imagebox()
	--fedora = image('/etc/favicon.png')
	--beautiful:add(fedora_icon)
	
	--mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
	--mylauncher = awful.widget.launcher({ image = image(fedora_icon),
	mylauncher = awful.widget.launcher({ image = beautiful.fedora_icon,
		                             menu = mymainmenu })

	-- Menubar configuration
	menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
	mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {}
myinfobox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
	   mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
	   mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
	   mywibox[s] = awful.wibox({ position = "top", screen = s })
	   myinfobox[s] = awful.wibox({ position = "bottom", screen = s })
    
-- 
-- DEFINE MY WIDGETS
--
	spacer = wibox.widget.textbox()
	spacer:set_text(' | ')
	empty = wibox.widget.textbox()
	empty:set_text(' ')
	txt_mem = wibox.widget.textbox()
	txt_mem:set_text('ram ')
	txt_mail = wibox.widget.textbox()
	txt_mail:set_text('mail ')
-- bat
	batt = wibox.widget.textbox()
	vicious.register(batt, vicious.widgets.bat, "⚡ $2% $1$3", 61, "BAT0")
-- mem	
	memvalue = wibox.widget.textbox()
	--vicious.register(memvalue, vicious.widgets.mem, "$1% - $2 / $3mb ")
	vicious.register(memvalue, vicious.widgets.mem, " used $2 / $3mb ($1%)")
	memwidget = awful.widget.progressbar()
	memwidget:set_width(8)
	memwidget:set_height(10)
	memwidget:set_vertical(true)
	memwidget:set_background_color("#494B4F")
	memwidget:set_border_color(nil)
	memwidget:set_color({ type = "linear", from = { 0, 0 }, to = { 10,0 }, stops = { {0, "#AECF96"}, {0.5, "#88A175"}, {1, "#FF5656"}}})
	vicious.register(memwidget, vicious.widgets.mem, "$1", 13)
-- wifi name & rate
	wifiwidget = wibox.widget.textbox()
	vicious.register(wifiwidget, vicious.widgets.wifi, '${ssid}' , 123, wifi)
	wifistr = wibox.widget.textbox()
	vicious.register(wifistr, vicious.widgets.wifi, ' (${link}%) ' , 124, wifi)		-- mode // sign // link
-- cpu C°
	thermwidget = wibox.widget.textbox()
	-- Nah this is no overkill...
	-- Its just a workaround for an 'unstable' 'hwmon/hwmon[12]' definition of Fedora21 - Rawhide
	-- Function (only) from: http://stackoverflow.com/questions/4990990/lua-check-if-a-file-exists
	function file_exists(name)
		local f=io.open(name,"r")
		if f~=nil then io.close(f) return true else return false end
	end
	thermal_ret = ""
	thermal_pre = "/sys/devices/platform/"
	thermal_base = "coretemp.0/hwmon/"
	
	if file_exists(thermal_pre .. thermal_base .. "hwmon1/temp2_input" )  then 
		thermal_ret = thermal_base .. "hwmon1"
	else 
		thermal_ret = thermal_base .. "hwmon2"
		-- so far only had these 2 entries, so this simple 'else' is enough.
	end
	vicious.register(thermwidget, vicious.widgets.thermal, "cpu $1 °C", 30, { thermal_ret, "core"}) 
	-- vicious.register(thermwidget, vicious.widgets.thermal, "cpu $1 °C", 30, { "coretemp.0/hwmon/hwmon1", "core"}) -- ${core} ${proc} | FALLBACK
	
-- cpu	usage
	cputext = wibox.widget.textbox()				-- Increases average load usage by +10-20%, with peeks of up to 90% 		
	vicious.register(cputext, vicious.widgets.cpu, " $1%, $2%, $3%, $4%") 	
	-- above is deprecated
	cpuwidget = awful.widget.graph()
	cpuwidget:set_width(50)
	cpuwidget:set_background_color("#494B4F")
	cpuwidget:set_color({ type = "linear", from = { 0, 0 }, to = { 10,0 }, stops = { {0, "#FF5656"}, {0.5, "#88A175"}, {1, "#AECF96" }}})
	vicious.register(cpuwidget, vicious.widgets.cpu, " $1") -- $2 $3")
-- uptime
	uptime = wibox.widget.textbox()
	vicious.register( uptime, vicious.widgets.uptime, "up $1d $2h $3min")
-- kernel	
	oswidget = wibox.widget.textbox()
	vicious.register(oswidget, vicious.widgets.os, "$2")
-- hdd C°
	hddtempwidget = wibox.widget.textbox()
	vicious.register(hddtempwidget, vicious.widgets.hddtemp, "${/dev/sda} °C", 19)

-- Disk usage widget
	diskwidget = wibox.widget.imagebox()
	diskwidget:set_image(awful.util.getdir("config") .. "/img/du.png")
	disk = require("widgets/diskusage")
	-- the first argument is the widget to trigger the diskusage ; -- the second/third is the percentage at which a line gets orange/red
	-- true = show only local filesystems
	disk.addToWidget(diskwidget, 75, 90, false)
-- Calendar widget to attach to the textclock
	require('widgets/calendar2')
	calendar2.addCalendarToWidget(mytextclock)

-- mpd
-- http://codepad.org/DFYrCllQ -- maybe for later use
	mpdwidget = wibox.widget.textbox()
	vicious.register(mpdwidget, vicious.widgets.mpd,
	    function (mpdwidget, args)
		if args["{state}"] == "Stop" then 
		    return " - "
		else 
		    return args["{Artist}"]..' - '.. args["{Title}"]
		end
	    end, 10)
-- Volume widget
	hlcolor = "#d7e0ea"
	volumewidget = wibox.widget.textbox()
	volumewidget:buttons({
	   button({  }, 4, function () volume("up", volumewidget) end),
	   button({  }, 5, function () volume("down", volumewidget) end),
	   button({  }, 1, function () volume("mute", volumewidget) end)
	})
	vicious.register(volumewidget, vicious.widgets.volume, " Vol: <span color='" .. hlcolor .. "'>$1$2</span> | ",61, "Master")
-- }}}
-- TOP BAR
	-- Widgets that are aligned to the left
	    local left_layout = wibox.layout.fixed.horizontal()
	    left_layout:add(mytaglist[s])
	    left_layout:add(mypromptbox[s])
	-- Widgets that are aligned to the right
	    local right_layout = wibox.layout.fixed.horizontal()
	    if s == 1 then right_layout:add(wibox.widget.systray()) end
	    right_layout:add(empty)
	    --right_layout:add(empty)
	    --right_layout:add(txt_mail)
	    right_layout:add(empty)
	    right_layout:add(volumewidget)
	    --right_layout:add(empty)
	    right_layout:add(mytextclock)
	    right_layout:add(empty)
	    right_layout:add(mylauncher)
	-- Now bring it all together (with the tasklist in the middle)
	    local layout = wibox.layout.align.horizontal()
	    layout:set_left(left_layout)
	    layout:set_middle(mytasklist[s])
	    layout:set_right(right_layout)
	-- Apply layout
	    mywibox[s]:set_widget(layout)
-- BOTTOM BAR
	-- Widgets that are aligned to the bottom - left
	    local bottom_left_layout = wibox.layout.fixed.horizontal()
	    bottom_left_layout:add(uptime)
	    bottom_left_layout:add(spacer)
	    bottom_left_layout:add(oswidget)
	    bottom_left_layout:add(spacer)
	    bottom_left_layout:add(wifiwidget)
	    bottom_left_layout:add(wifistr)
	   -- bottom_left_layout:add(spacer)
	   -- bottom_left_layout:add(mpdwidget)
	-- Widgets that are aligned to the bottom - right
	    local bottom_right_layout = wibox.layout.fixed.horizontal()
	    bottom_right_layout:add(thermwidget)
	    bottom_right_layout:add(empty)
	    bottom_right_layout:add(cpuwidget)
	    bottom_right_layout:add(empty)
	    -- Increases average load usage by +10-20%, with peeks of up to 90% 
	    bottom_right_layout:add(cputext)
	    bottom_right_layout:add(spacer)
	    bottom_right_layout:add(txt_mem)
	    bottom_right_layout:add(memwidget)
	    bottom_right_layout:add(empty)
	    bottom_right_layout:add(memvalue)
	    bottom_right_layout:add(spacer)
	    -- SEEMS BUGGY.. TODO WHY?
	    -- bottom_right_layout:add(hddtempwidget)
	    --bottom_right_layout:add(spacer)
	    bottom_right_layout:add(batt)
	    bottom_right_layout:add(spacer)
	    bottom_right_layout:add(diskwidget)
	    bottom_right_layout:add(spacer)
	    bottom_right_layout:add(mylayoutbox[s])
	-- Now bring it all together
	    local layout_bottom = wibox.layout.align.horizontal()
	    layout_bottom:set_left(bottom_left_layout)
	    layout_bottom:set_right(bottom_right_layout)
	-- Apply layout
	    myinfobox[s]:set_widget(layout_bottom)
	end
-- }}}

-- {{{ Mouse bindings
	root.buttons(awful.util.table.join(
	    awful.button({ }, 3, function () mymainmenu:toggle() end),
	    awful.button({ }, 4, awful.tag.viewnext),
	    awful.button({ }, 5, awful.tag.viewprev)
	))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    -- changed from default 'w' to 'm'
    awful.key({ modkey,           }, "m", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Volume controls | Multimedia keys: Volume Up/Down Mute
    awful.key({ }, "XF86AudioRaiseVolume", function () volume("up", volumewidget) end),
    awful.key({ }, "XF86AudioLowerVolume", function () volume("down", volumewidget) end),
    awful.key({ }, "XF86AudioMute", function () volume("mute", volumewidget) end),

    -- Sea's keybindings
    awful.key({ modkey           }, "e", files),
    awful.key({ modkey           }, "t", ftp),
    awful.key({ modkey           }, "w", browser),
    awful.key({ modkey           }, "i", irc),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.movetotag(tag)
                     end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      local tag = awful.tag.gettags(client.focus.screen)[i]
                      if client.focus and tag then
                          awful.client.toggletag(tag)
                      end
                  end))
end

	clientbuttons = awful.util.table.join(
	    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
	    awful.button({ modkey }, 1, awful.mouse.client.move),
	    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
	root.keys(globalkeys)
-- }}}

-- {{{ Rules
	awful.rules.rules = {
	    -- All clients will match this rule.
	    { rule = { },
	      properties = { border_width = beautiful.border_width,
		             border_color = beautiful.border_normal,
		             focus = awful.client.focus.filter,
		             keys = clientkeys,
		             buttons = clientbuttons } },
	    { rule = { class = "MPlayer" },
	      properties = { floating = true } },
	    { rule = { class = "pinentry" },
	      properties = { floating = true } },
	    { rule = { class = "gimp" },
	      properties = { floating = true } },
	    -- Set Firefox to always map on tags number 2 of screen 1.
	    { rule = { instance = "lxterminal" },
	      properties = { tag = tags[1][1] } },
	    { rule = { instance = "pcmanfm" },
	      properties = { tag = tags[1][2] } },
	    { rule = { class = "Firefox" },
	      properties = { tag = tags[1][3] } },
	    { rule = { instance = "gedit" },
	      properties = { tag = tags[1][4] } },
	    { rule = { instance = "pluma" },
	      properties = { tag = tags[1][4] } },
	    { rule = { class = "Xchat" },
	      properties = { tag = tags[1][5] } },
	    { rule = { class = "Thunderbird" },
	      properties = { tag = tags[1][6] } },
	    { rule = { class = "Transmission" },
	      properties = { tag = tags[1][7] } },
	    { rule = { instance = "filezilla" },
		properties = { tag = tags[1][7] } },
	}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{	Autostart applications || disable during testing !
	awful.util.spawn_with_shell( terminal )
	awful.util.spawn_with_shell( files )
	awful.util.spawn_with_shell( internet )
	awful.util.spawn_with_shell( editor )
	--awful.util.spawn_with_shell( irc )
	awful.util.spawn_with_shell( email )
	awful.util.spawn_with_shell( "transmission-gtk" )
	--awful.util.spawn_with_shell( ftp )
	--awful.util.spawn_with_shell( "feh --bg-fill " .. awful.util.getdir("config") .. "/img/flower-002-dark-blue-16.png &")
	awful.util.spawn_with_shell( term_cmd .. awful.util.getdir("config") .. "/scripts/nasaBackground-new.sh")
	--awful.util.spawn_with_shell( term_cmd .. awful.util.getdir("config") .. "/scripts/nasaBackground-org.sh")
	-- Disable xscreensaver to have a simple blackout
	awful.util.spawn_with_shell( "xscreensaver &" )
-- }}}
