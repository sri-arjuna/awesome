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

theme.tasklist_floating_icon = DIR_SHARED .. "/default/tasklist/floatingw.png"

theme.menu_submenu_icon = DIR_SHARED .. "/default/submenu.png"
theme.menu_height   = "19"
theme.menu_width    = "135"

-- Define the image to load
theme.titlebar_close_button_normal = DIR_SHARED .. "/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = DIR_SHARED .. "/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = DIR_SHARED .. "/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = DIR_SHARED .. "/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = DIR_SHARED .. "/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = DIR_SHARED .. "/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = DIR_SHARED .. "/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = DIR_SHARED .. "/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = DIR_SHARED .. "/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = DIR_SHARED .. "/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = DIR_SHARED .. "/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = DIR_SHARED .. "/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = DIR_SHARED .. "/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = DIR_SHARED .. "/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = DIR_SHARED .. "/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = DIR_SHARED .. "/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = DIR_SHARED .. "/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = DIR_SHARED .. "/default/titlebar/maximized_focus_active.png"

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


theme.widget_disk     = DIR_RC .. "/dust/disk.png"
theme.widget_ac       = DIR_RC .. "/dust/ac.png"
theme.widget_acblink  = DIR_RC .. "/dust/acblink.png"
theme.widget_blank    = DIR_RC .. "/dust/blank.png"
theme.widget_batfull  = DIR_RC .. "/dust/batfull.png"
theme.widget_batmed   = DIR_RC .. "/dust/batmed.png"
theme.widget_batlow   = DIR_RC .. "/dust/batlow.png"
theme.widget_batempty = DIR_RC .. "/dust/batempty.png"
theme.widget_vol      = DIR_RC .. "/dust/vol.png"
theme.widget_mute     = DIR_RC .. "/dust/mute.png"
theme.widget_pac      = DIR_RC .. "/dust/pac.png"
theme.widget_pacnew   = DIR_RC .. "/dust/pacnew.png"
theme.widget_mail     = DIR_RC .. "/dust/mail.png"
theme.widget_mailnew  = DIR_RC .. "/dust/mailnew.png"
theme.widget_temp     = DIR_RC .. "/dust/temp.png"
theme.widget_tempwarm = DIR_RC .. "/dust/tempwarm.png"
theme.widget_temphot  = DIR_RC .. "/dust/temphot.png"
theme.widget_wifi     = DIR_RC .. "/dust/wifi.png"
theme.widget_nowifi   = DIR_RC .. "/dust/nowifi.png"
theme.widget_mpd      = DIR_RC .. "/dust/mpd.png"
theme.widget_play     = DIR_RC .. "/dust/play.png"
theme.widget_pause    = DIR_RC .. "/dust/pause.png"
theme.widget_ram      = DIR_RC .. "/dust/ram.png"

theme.widget_mem      = DIR_RC .. "/dust12/ram.png"
theme.widget_swap     = DIR_RC .. "/dust12/swap.png"
theme.widget_fs       = DIR_RC .. "/dust12/fs_01.png"
theme.widget_fs2      = DIR_RC .. "/dust12/fs_02.png"
theme.widget_up       = DIR_RC .. "/dust12/up.png"
theme.widget_down     = DIR_RC .. "/dust12/down.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
