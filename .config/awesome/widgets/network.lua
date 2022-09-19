local lain = require("lain")

local widget = wibox.widget {
  {
    {
      id = "icon",
      image = beautiful.icon_loading,
      resize = true,
      widget = wibox.widget.imagebox
    },
    margins = dpi(4),
    layout = wibox.container.margin
  },
  {
    id = "text",
    text = "...",
    widget = wibox.widget.textbox
  },
  spacing = dpi(4),
  layout = wibox.layout.fixed.horizontal
}

widget.icon = widget:get_children_by_id("icon")[1]
widget.text = widget:get_children_by_id("text")[1]

tooltip(widget)

widget.tooltip.update = function (online, type, device)
  if online then
    widget.tooltip.markup = markup.fg(beautiful.fg_focus, type) .. "\n/dev/" .. markup.bold(device)
  else
    widget.tooltip.markup = markup.fg(beautiful.fg_urgent, "offline")
  end
end

lain.widget.net {
  settings = function () widget.text.text = net_now.received .. "↓↑" .. net_now.sent end
}

widget.update = function ()
  awful.spawn.easy_async_with_shell("nmcli d | grep connected | head -1", function (stdout)
    local d = {}
    if #stdout > 0 then
      for w in string.gmatch(stdout, "[^ ]+") do table.insert(d, w) end
    end
    if #stdout == 0 or #d == 0 then
      widget.icon.image = beautiful.icon_network_offline
      widget.tooltip.update(false, nil, nil)
    else
      local device = d[1]
      local type = d[2]
      if type == "ethernet" then
        widget.icon.image = beautiful.icon_network_ethernet
      elseif type == "wifi" then
        widget.icon.image = beautiful.icon_network_wifi
      else
        widget.icon.image = beautiful.icon_network_online
      end
      widget.tooltip.update(true, type, device)
    end
  end)
end

widget:update()

widget:buttons(gears.table.join(
  awful.button({}, mouse_left, function () awful.spawn(defaults.network) end)
))

return widget
