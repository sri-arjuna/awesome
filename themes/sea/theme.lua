-- dust, awesome3 theme, based off of the gtk+ theme dust, by tdy
-- Modified for 'sea's spacy' theme

--{{{ Main
--local awful = require("awful")
--awful.util = require("awful.util")

theme = {}


--
--  Distro Specific default (initial) wallpaper & icons
--
    theme.icon_awesome =  DIR_ICONS .. "/os/awesome14-dust.png"
    if file_exists("/etc/fedora-release")
    then    -- Fedora
            theme.icon_os = "/etc/favicon.png"
	    theme.wallpaper = DIR_WALLPAPER .. "/geometry-flower-002-dark-blue-16.png"
	    --naughty.notify({ preset = naughty.config.presets.info, title = "Its fedora", text = err })
    else    if file_exists("/etc/arch-release")
            then    -- Its Arch
                    theme.icon_os =  DIR_ICONS .. "/os/arch_icon_14.png"
                    theme.wallpaper = DIR_WALLPAPER .. "/arch_fhd.png"
            else    -- Fallback 'neutral' values
                    theme.icon_os =  theme.icon_awesome
                    theme.wallpaper = DIR_WALLPAPER .. "/geometry-flower-002-dark-blue-16.png"
            end
    end





if awful.util.file_readable(DIR_WIDGETS .. "/vain/init.lua") then
    theme.useless_gap_width  = "1"
    dofile(DIR_WIDGETS .. "/vain/init.lua")
end
--}}}

theme.font          = "anorexia 9"

theme.bg_normal     = "#030303"
theme.bg_focus      = "#a3a3a3"
theme.bg_urgent     = "#4343cd"
theme.bg_minimize   = "#4b4b4b"

theme.fg_normal     = "#838383"
theme.fg_focus      = "#FFFFFF"
theme.fg_urgent     = "#000000"
theme.fg_minimize   = "#F0F0F0"

theme.border_width  = "0"
theme.border_normal = "#000000"
theme.border_focus  = "#000000"
theme.border_marked = "#000000"

theme.taglist_squares_sel = DIR_THEME .. "/taglist14/squaref.png"
theme.taglist_squares_unsel = DIR_THEME .. "/taglist14/square.png"

theme.tasklist_floating_icon = DIR_SHAREDTHEMES .. "/default/tasklist/floatingw.png"

theme.menu_submenu_icon = DIR_SHAREDTHEMES .. "/default/submenu.png"
theme.menu_height   = "19"
theme.menu_width    = "135"

-- Define the image to load
theme.titlebar_close_button_normal = DIR_SHAREDTHEMES .. "/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = DIR_SHAREDTHEMES .. "/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = DIR_SHAREDTHEMES .. "/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = DIR_SHAREDTHEMES .. "/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = DIR_SHAREDTHEMES .. "/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = DIR_SHAREDTHEMES .. "/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = DIR_SHAREDTHEMES .. "/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = DIR_SHAREDTHEMES .. "/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = DIR_SHAREDTHEMES .. "/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = DIR_SHAREDTHEMES .. "/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = DIR_SHAREDTHEMES .. "/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = DIR_SHAREDTHEMES .. "/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = DIR_SHAREDTHEMES .. "/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = DIR_SHAREDTHEMES .. "/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = DIR_SHAREDTHEMES .. "/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = DIR_SHAREDTHEMES .. "/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = DIR_SHAREDTHEMES .. "/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = DIR_SHAREDTHEMES .. "/default/titlebar/maximized_focus_active.png"

theme.layout_fairh      = DIR_THEME .. "/layouts14/fairhw.png"
theme.layout_fairv      = DIR_THEME .. "/layouts14/fairvw.png"
theme.layout_floating   = DIR_THEME .. "/layouts14/floatingw.png"
theme.layout_magnifier  = DIR_THEME .. "/layouts14/magnifierw.png"
theme.layout_max        = DIR_THEME .. "/layouts14/maxw.png"
theme.layout_fullscreen = DIR_THEME .. "/layouts14/fullscreenw.png"
theme.layout_tilebottom = DIR_THEME .. "/layouts14/tilebottomw.png"
theme.layout_tileleft   = DIR_THEME .. "/layouts14/tileleftw.png"
theme.layout_tile       = DIR_THEME .. "/layouts14/tilew.png"
theme.layout_tiletop    = DIR_THEME .. "/layouts14/tiletopw.png"
theme.layout_spiral     = DIR_THEME .. "/layouts14/spiralw.png"
theme.layout_dwindle    = DIR_THEME .. "/layouts14/dwindlew.png"


theme.widget_disk     = DIR_ICONS .. "/dust/disk.png"
theme.widget_ac       = DIR_ICONS .. "/dust/ac.png"
theme.widget_acblink  = DIR_ICONS .. "/dust/acblink.png"
theme.widget_blank    = DIR_ICONS .. "/dust/blank.png"
theme.widget_batfull  = DIR_ICONS .. "/dust/batfull.png"
theme.widget_batmed   = DIR_ICONS .. "/dust/batmed.png"
theme.widget_batlow   = DIR_ICONS .. "/dust/batlow.png"
theme.widget_batempty = DIR_ICONS .. "/dust/batempty.png"
theme.widget_vol      = DIR_ICONS .. "/dust/vol.png"
theme.widget_mute     = DIR_ICONS .. "/dust/mute.png"
theme.widget_pac      = DIR_ICONS .. "/dust/pac.png"
theme.widget_pacnew   = DIR_ICONS .. "/dust/pacnew.png"
theme.widget_mail     = DIR_ICONS .. "/dust/mail.png"
theme.widget_mailnew  = DIR_ICONS .. "/dust/mailnew.png"
theme.widget_temp     = DIR_ICONS .. "/dust/temp.png"
theme.widget_tempwarm = DIR_ICONS .. "/dust/tempwarm.png"
theme.widget_temphot  = DIR_ICONS .. "/dust/temphot.png"
theme.widget_wifi     = DIR_ICONS .. "/dust/wifi.png"
theme.widget_nowifi   = DIR_ICONS .. "/dust/nowifi.png"
theme.widget_mpd      = DIR_ICONS .. "/dust/mpd.png"
theme.widget_play     = DIR_ICONS .. "/dust/play.png"
theme.widget_pause    = DIR_ICONS .. "/dust/pause.png"
theme.widget_ram      = DIR_ICONS .. "/dust/ram.png"

--theme.widget_mem      = DIR_ICONS .. "/dust12/ram.png"
--theme.widget_swap     = DIR_ICONS .. "/dust12/swap.png"
--theme.widget_fs       = DIR_ICONS .. "/dust12/fs_01.png"
--theme.widget_fs2      = DIR_ICONS .. "/dust12/fs_02.png"
--theme.widget_up       = DIR_ICONS .. "/dust12/up.png"
--theme.widget_down     = DIR_ICONS .. "/dust12/down.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
