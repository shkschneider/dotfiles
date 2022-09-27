local naughty = require("naughty")

naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.title = nil

naughty.config.defaults.ontop = true
naughty.config.defaults.margin = dpi(8)
naughty.config.defaults.border_width = 0
naughty.config.defaults.position = "top_right"
naughty.config.defaults.font = font
naughty.config.defaults.hover_timeout = nil
naughty.config.padding = dpi(8)
naughty.config.spacing = dpi(8)

beautiful.notification_font = beautiful.font
beautiful.notification_bg = beautiful.bg_normal
beautiful.notification_fg = beautiful.fg_normal
beautiful.notification_border_width = 0
beautiful.notification_shape = nil
beautiful.notification_opacity = 1.0
beautiful.notification_margin = dpi(8)
beautiful.notification_spacing = dpi(8)

--[[
naughty.config.presets.low = {
  timeout = 1,
  bg = beautiful.bg_normal,
  fg = beautiful.fg_normal
}
naughty.config.presets.normal = {
  timeout = 3,
  bg = beautiful.bg_normal,
  fg = beautiful.fg_focus
}
naughty.config.presets.critical = {
  timeout = 0,
  bg = beautiful.bg_normal,
  fg = beautiful.fg_urgent
}
--naughty.config.defaults.timeout = naughty.config.presets.normal.timeout
--]]

function notify(title, text) -- FIXME
  -- low normal critical
  naughty.notify({ preset = naughty.config.presets.normal, title = title, text = text})
end

if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical, title = "Oops, there were errors during startup!", text = awesome.startup_errors })
end
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    if in_error then return end
    in_error = true
    naughty.notify({ preset = naughty.config.presets.critical, title = "Oops, an error happened!", text = tostring(err) })
    in_error = false
  end)
end

--[[ TODO
naughty.connect_signal("request::display", function (n)
  local icon = n.app_icon
  -- TODO if not icon then
  local time = os.date("%H:%M")
  naughty.layout.box {
    notification = n,
    type = "notification",
    -- TODO widget_template
  }
end)
--]]
