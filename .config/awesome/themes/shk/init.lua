-- https://elv13.github.io/documentation/06-appearance.md.html

screen.connect_signal("arrange", function (s)
  local single = #s.tiled_clients == 1
  for _, c in pairs(s.clients) do
    if single and not c.floating or c.maximized or c.fullscreen then
      c.border_width = 0
    else
      c.border_width = beautiful.border_width
    end
  end
end)

--[[
client.connect_signal("focus", function (c)
  c.border_color = beautiful.border_focus
  --c.opacity = 1.00
end)
client.connect_signal("unfocus", function (c)
  c.border_color = beautiful.border_normal
  --c.opacity = 0.85
end)
--]]

-- horizon-dark
local colors = {
  black = "#16161c",
  white = "#d5d8da",
  background = "#1c1e26",
  foreground = "#e0e0e0",
  comment = "#75715E",
  red = "#ec6a88",
  orange = "#FD971F",
  yellow = "#fbc3a7",
  green = "#3fdaa4",
  blue = "#3fc4de",
  purple = "#f075b5",
  transparent = "#00000000"
}
-- https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4
beautiful.opacity = 0.85
beautiful.alpha = "CC"

beautiful._font = "JetBrains Mono"
beautiful.font = beautiful._font .. " 10"
beautiful.useless_gap = dpi(4)
beautiful.border_width = 0
beautiful.border_normal = colors.black
beautiful.border_focus = colors.white
beautiful.border_marked = colors.white
beautiful.wallpaper = gears.filesystem.get_configuration_dir() .. "themes/shk/wallpaper"

beautiful.fg_normal = colors.foreground
beautiful.fg_focus = colors.orange
beautiful.fg_urgent = colors.red
beautiful.fg_minimize = beautiful.fg_normal

beautiful.bg_normal = colors.background
beautiful.bg_focus = beautiful.bg_normal
beautiful.bg_urgent = beautiful.bg_normal
beautiful.bg_minimize = beautiful.bg_normal
beautiful.bg_systray = beautiful.bg_normal

-- ...

beautiful.taglist_bg_focus = beautiful.fg_urgent
beautiful.taglist_bg_occupied = colors.transparent
beautiful.taglist_bg_urgent = colors.transparent
beautiful.taglist_bg_empty = colors.transparent
beautiful.taglist_fg_focus = beautiful.fg_focus
beautiful.taglist_fg_occupied = beautiful.fg_focus
beautiful.taglist_fg_urgent = beautiful.fg_urgent
beautiful.taglist_fg_empty = beautiful.fg_normal
beautiful.taglist_spacing = nil
beautiful.taglist_font = beautiful.font
beautiful.taglist_disable_icon = true

beautiful.icon_theme = "Papirus-Dark"

beautiful.tooltip_bg = colors.background
beautiful.tooltip_fg = colors.normal

beautiful.hotkeys_bg = beautiful.bg_normal
beautiful.hotkeys_fg = beautiful.fg_normal
beautiful.hotkeys_modifiers_fg = beautiful.fg_focus
beautiful.hotkeys_border_width = 0
--beautiful.hotkeys_shape = gears.shape.rounded_rect

beautiful.shape = function (cr, w, h)
  return gears.shape.rounded_rect(cr, w, h, 8)
end

beautiful.systray_icon_spacing = dpi(2)
beautiful.useless_gap = dpi(4)
