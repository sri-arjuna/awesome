-- @author Simon Arjuna Erat (sea / sri-arjuna, erat.simon@gmail.com)
-- This is my very first widget.
-- 'diskusage.lua' (by Peter J. Kranz (Absurd-Mind, peter@myref.net)) was taken as template
-- Any questions, criticism or praise just drop me an email

-- its invoked like:
-- disk.addToWidget(diskwidget, 75, 90, false)

-- volumewidget = wibox.widget.imagebox()
-- volumewidget:set_image(DIR_ICONS .. "/du.png")
-- volume = require("widgets/volume.lua")
-- disk.addToWidget(volumewidget)

--
-- 	Variables
--
	-- Import
	local os = os
	local io = { popen = io.popen }
	local print = print
	local string = string
	local tostring = tostring
	local setmetatable = setmetatable
	local awful = awful
	local DIR_HOME = DIR_HOME
	local DIR_BASE = DIR_BASE
	local DIR_RC = DIR_RC
	local DIR_SCRIPTS = DIR_SCRIPTS
	local DIR_ICONS = DIR_ICONS
	local DIR_WIDGETS = DIR_WIDGETS
	-- Internal stuff here
	module("volume")	-- as this seems quiet strict
	M = {}
	local usage = {}
	local volume = {
		
	}
	local SCRIPT	= DIR_SCRIPTS .. "/snd.sh"
	local ICONS	= DIR_ICONS .. "/snd/"
--
--	Functions
--
	-- Using file_exist(file) and and get_bash_string(file,args) as predefined in rc/all_functions
	function volume_icon()
		vol_icon 	= get_bash_string( SCRIPT , "image")
		volume_icon:set_image(ICONS .. vol_icon)
	end
	function volume_up()
		b = os.execute(SCRIPT,"up")
		return b
	end
	function volume_down()
		b = os.execute(SCRIPT,"down")
		return b
	end
	function volume_mute()
		b = os.execute(SCRIPT,"mute")
		return b
	end
	function volume_value()
		s = get_bash_string(SCRIPT,"vol")
		-- print(s)
		return s
	end
	local function worker(format, warg)
		-- Fallback to default hddtemp port
		if warg == nil then warg = 7634 end

		local volume = {
			up = volume_up,
			down = volume_down,
			mute = volume_mute,
			icon = volume_icon,
			value = volume_value
		} -- Get info from the hddtemp daemon
		return volume
	end
--
--	Action
--
	return setmetatable(volume, { __call = function(_, ...) return worker(...) end })
	-- ignore down here....
	-- return was already before this comment
	
	
--	function M.addToWidget(mywidget, myintervall)
		-- volume = volume_value()
		
--		mywidget:connect_signal('mouse::enter', function ()
--			usage = mywidget:set_image(get_bash_string( SCRIPT , "image"))
--		end)
--		mywidget:connect_signal('mouse::leave', function () naughty.destroy(usage) end)
--	end
--return M

