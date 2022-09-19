require("widgets")

local function widget(s, position)
  return awful.wibox {
    position = position,
    stretch = true,
    border_width = 0,
    ontop = false, -- to allow fullscreen
    type = "dock", -- desktop dock splash dialog menu toolbar utility normal...
    width = s.geometry.width,
    height = dpi(32),
    screen = s,
    bg = beautiful.bg_normal .. "00",
    fg = beautiful.fg_normal .. "FF",
  }
end

awful.screen.connect_for_each_screen(function (s)
  awful.tag({ "A", "W", "E", "S", "O", "M", "E" }, s, awful.layout.layouts[1])
  require("panel-top")(widget(s, "top"))
  --require("panel-bottom")(widget(s, "bottom"))
end)
