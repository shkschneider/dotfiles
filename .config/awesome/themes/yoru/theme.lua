local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local colors = {
  black = "#232526",
  white = "#e4e6e7",
  background = "#0c0e0f",
  foreground = "#edeff0",
  red = "#df5b61",
  green = "#78b892",
  yellow = "#de8f78",
  blue = "#36791c9",
  magenta = "#bc83e3",
  cyan = "#67afc1",
  alpha = "80"
}

local theme = {}

theme.font = "JetBrains Mono Regular 10"
theme.useless_gap = dpi(4)
theme.border_width = dpi(1)
theme.border_normal = colors.black
theme.border_focus = colors.white
theme.border_marked = colors.white
theme.wallpaper = nil

theme.opacity = 0.8

theme.bg_normal = colors.background
theme.bg_focus = theme.bg_normal
theme.bg_urgent = theme.bg_normal
theme.bg_minimize = theme.bg_normal
theme.bg_systray = theme.bg_normal

theme.fg_normal = colors.foreground
theme.fg_focus = theme.fg_normal
theme.fg_urgent = theme.fg_normal
theme.fg_minimize = theme.fg_normal

return theme
