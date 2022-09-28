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
beautiful.notification_shape = beautiful.shape
beautiful.notification_opacity = 1.0
beautiful.notification_margin = dpi(8)
beautiful.notification_spacing = dpi(8)
beautiful.notification_icon_size = dpi(32)

_notifications = {}

local function notify(urgency, icon, title, text)
  local id = 0
  for _, notification in pairs(_notifications) do
    if notification.title == title then
      id = notification.id
      break
    end
  end
  --awful.spawn.with_shell(string.format("dunstify --urgency='%s' --icon='%s' --hints='string:x-dunst-stack-tag:%s' '%s' '%s'", urgency, icon, title, title, text))
  awful.spawn.easy_async_with_shell(string.format("notify-send -u '%s' -i '%s' -r '%d' -p '%s' '%s'", urgency, icon, id, title, text), function (stdout)
    table.insert(_notifications, { title = title, id = string.trim(stdout) })
  end)
end

function notify_low(icon, title, text)
  notify("low", icon, title, text)
end

function notify_normal(icon, title, text)
  notify("normal", icon, title, text)
end

function notify_critical(icon, title, text)
  notify("critical", icon, title, text)
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
