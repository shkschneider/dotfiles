assert(dpi)
local theme = {}
theme.alpha = "D9" -- 85%
theme.colors = require "colors.horizon"
theme.colors.null = "#00000000"
theme.font = "JetBrainsMono 11"
theme.margin = dpi(8)
theme.opacity = 0.85
theme.padding = dpi(4)
theme.shape = function (cr, w, h) return gears.shape.rounded_rect(cr, w, h, 8) end

theme.arcchart_paddings = theme.padding
theme.bg_focus = theme.colors.black
theme.bg_minimize = theme.colors.background
theme.bg_normal = theme.colors.background
theme.bg_systray = theme.colors.background
theme.bg_urgent = theme.colors.background
theme.border_focus = theme.colors.null
theme.border_marked = theme.colors.focus
theme.border_normal = theme.colors.null
theme.border_width = 0
theme.fg_focus = theme.colors.focus
theme.fg_minimize = theme.colors.normal .. theme.alpha
theme.fg_normal = theme.colors.normal
theme.fg_urgent = theme.colors.urgent

theme.arcchart_border_width = theme.border_width
theme.fullscreen_hide_border = true
theme.gap_single_client = true
theme.hotkeys_bg = theme.bg_normal
theme.hotkeys_border_width = theme.border_width
theme.hotkeys_fg = theme.fg_normal
theme.hotkeys_modifiers_fg = theme.fg_focus
theme.hotkeys_shape = nil
theme.icon_theme = nil
theme.maximized_hide_border = true
theme.menu_submenu_icon = nil
theme.menu_font = theme.font
theme.menu_height = dpi(32)
theme.menu_width = dpi(128)
theme.menu_border_color = theme.fg_normal
theme.menu_border_width = theme.border_width
theme.menu_fg_focus = theme.fg_focus
theme.menu_bg_focus = theme.bg_focus
theme.menu_fg_normal = theme.fg_normal
theme.menu_bg_normal = theme.bg_normal
--theme.menu_submenu = "/>"
theme.separator_thickness = dpi(1)
theme.separator_border_color = nil
theme.separator_color = theme.fg_normal
theme.systray_icon_spacing = dpi(2)
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_bg_focus = theme.bg_normal
theme.taglist_bg_occupied = theme.bg_normal
theme.taglist_bg_urgent = theme.bg_normal
theme.taglist_disable_icon = true
theme.taglist_fg_empty = theme.fg_normal
theme.taglist_fg_focus = theme.fg_focus
theme.taglist_fg_occupied = theme.fg_focus
theme.taglist_fg_urgent = theme.fg_urgent
theme.taglist_font = theme.font
theme.taglist_spacing = nil
theme.tooltip_bg = theme.bg_normal
theme.tooltip_fg = theme.fg_normal
theme.tooltip_opacity = theme.opacity
theme.useless_gap = theme.padding

theme.wallpapers = {}
theme.wallpapers["25th_hour"] = function ()
    if bling then
        return bling.module.wallpaper.setup {
            set_function = bling.module.wallpaper.setters.simple_schedule,
            wallpaper = {
                ["00:00:00"] = nice.places.wallpapers .. "25th_hour/0000.png",
                ["01:30:00"] = nice.places.wallpapers .. "25th_hour/0130.png",
                ["03:00:00"] = nice.places.wallpapers .. "25th_hour/0300.png",
                ["04:30:00"] = nice.places.wallpapers .. "25th_hour/0430.png",
                ["06:00:00"] = nice.places.wallpapers .. "25th_hour/0600.png",
                ["07:30:00"] = nice.places.wallpapers .. "25th_hour/0730.png",
                ["09:00:00"] = nice.places.wallpapers .. "25th_hour/0900.png",
                ["10:30:00"] = nice.places.wallpapers .. "25th_hour/1030.png",
                ["12:00:00"] = nice.places.wallpapers .. "25th_hour/1200.png",
                ["13:30:00"] = nice.places.wallpapers .. "25th_hour/1330.png",
                ["15:00:00"] = nice.places.wallpapers .. "25th_hour/1500.png",
                ["16:30:00"] = nice.places.wallpapers .. "25th_hour/1630.png",
                ["18:00:00"] = nice.places.wallpapers .. "25th_hour/1800.png",
                ["19:30:00"] = nice.places.wallpapers .. "25th_hour/1930.png",
                ["21:00:00"] = nice.places.wallpapers .. "25th_hour/2100.png",
                ["22:30:00"] = nice.places.wallpapers .. "25th_hour/2230.png"
            },
            position = "maximized"
        }
    else
        nice.a.script("wallpaper.sh", function (out)
            nice.wallpaper(awful.screen.focused(), string.trim(out))
        end)
    end
end

theme.wallpapers["random"] = function ()
    if bling then
        bling.module.wallpaper.setup {
            set_function = bling.module.wallpaper.setters.random,
            wallpaper = { nice.places.wallpapers },
            change_timer = 631,
            position = "maximized",
            background = beautiful.bg_normal
        }
    else
        nice.a.sync("find " .. nice.places.config .. "wm/wallpapers/ -maxdepth 1 -type f | sort --random-sort | head -1", function (out)
            nice.wallpaper(awful.screen.focused(), string.trim(out))
        end)
    end
end
theme.wallpaper = theme.wallpapers["25th_hour"]

theme.notification_bg = theme.bg_normal
theme.notification_border_width = theme.border_width
theme.notification_fg = theme.fg_normal
theme.notification_font = theme.font
theme.notification_icon_size = dpi(32)
theme.notification_margin = theme.margin
theme.notification_opacity = theme.opacity
theme.notification_shape = theme.shape
theme.notification_spacing = theme.padding
local naughty = require "naughty"
naughty.config.defaults.border_width = theme.border_width
naughty.config.defaults.font = theme.font
naughty.config.defaults.hover_timeout = nil
naughty.config.defaults.margin = theme.margin
naughty.config.defaults.ontop = true
naughty.config.defaults.position = "top_middle"
naughty.config.defaults.screen = 1
naughty.config.defaults.title = nil
naughty.config.padding = theme.margin
naughty.config.presets.critical.bg = theme.fg_urgent
naughty.config.presets.critical.fg = theme.bg_urgent
naughty.config.presets.critical.timeout = 0
naughty.config.presets.low.bg = theme.bg_normal
naughty.config.presets.low.fg = theme.fg_normal
naughty.config.presets.low.timeout = 1
naughty.config.presets.normal.bg = theme.bg_focus
naughty.config.presets.normal.fg = theme.fg_focus
naughty.config.presets.normal.timeout = 3
naughty.config.spacing = theme.padding

return theme
