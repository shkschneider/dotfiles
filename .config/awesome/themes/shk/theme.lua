-- https://elv13.github.io/documentation/06-appearance.md.html

local theme = {}

-- horizon-dark
theme.color = {
  black = "#16161c",
  white = "#d5d8da",
  bg = "#1c1e26",
  normal = "#e0e0e0",
  focus = "#fd971f",
  urgent = "#f075b5",
  none = "#00000000",
  nil
}

-- https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4
theme.opacity = 0.80
theme.alpha = "CC"

theme._font = "JetBrains Mono"
theme.font = theme._font .. " 10"
theme.useless_gap = dpi(4)
theme.border_width = 0
theme.border_normal = theme.color.normal
theme.border_focus = theme.color.focus
theme.border_marked = theme.color.urgent
theme.wallpaper = gears.filesystem.get_configuration_dir() .. "wallpaper"

theme.fg_normal = theme.color.normal
theme.fg_focus = theme.color.focus
theme.fg_urgent = theme.color.urgent
theme.fg_minimize = theme.color.normal .. theme.alpha

theme.bg_normal = theme.color.bg
theme.bg_focus = theme.color.bg
theme.bg_urgent = theme.color.bg
theme.bg_minimize = theme.color.bg
theme.bg_systray = theme.color.bg

theme.taglist_bg_focus = theme.color.bg
theme.taglist_bg_occupied = theme.color.bg
theme.taglist_bg_urgent = theme.color.bg
theme.taglist_bg_empty = theme.color.bg
theme.taglist_fg_focus = theme.color.focus
theme.taglist_fg_occupied = theme.color.focus
theme.taglist_fg_urgent = theme.color.urgent
theme.taglist_fg_empty = theme.color.normal
theme.taglist_spacing = nil
theme.taglist_font = theme.font
theme.taglist_disable_icon = true

theme.tooltip_bg = theme.color.bg
theme.tooltip_fg = theme.color.normal

theme.hotkeys_bg = theme.color.bg
theme.hotkeys_fg = theme.color.fg
theme.hotkeys_modifiers_fg = theme.color.focus
--theme.hotkeys_border_width = 0
theme.hotkeys_shape = nil

theme.shape = function (cr, w, h)
  return gears.shape.rounded_rect(cr, w, h, 8)
end

theme.systray_icon_spacing = dpi(2)
theme.useless_gap = dpi(4)

theme.icon_theme = nil

return theme
