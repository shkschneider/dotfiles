-- playerctl

local widget = wibox.widget {
  {
    {
      id = "bar",
      orientation = "horizontal",
      thickness = dpi(1),
      span_ratio = 0.0,
      forced_width = 0,
      color = beautiful.fg_focus,
      opacity = 0.5,
      widget = wibox.widget.separator
    },
    top = dpi(24), bottom = dpi(4),
    left = dpi(16), right = dpi(16),
    layout = wibox.container.margin
  },
  {
    {
      {
        id = "icon",
        image = beautiful.icon_loading,
        resize = true,
        widget = wibox.widget.imagebox,
      },
      top = dpi(4), bottom = dpi(4),
      left = dpi(4), right = dpi(2),
      layout = wibox.container.margin,
    },
    {
      {
        id = "text",
        ellipsize = "end",
        widget = wibox.widget.textbox
      },
      top = dpi(4), bottom = dpi(4),
      left = dpi(2), right = dpi(8),
      layout = wibox.container.margin,
    },
    layout = wibox.layout.fixed.horizontal
  },
  layout = wibox.layout.stack
}

widget.icon = widget:get_children_by_id("icon")[1]
widget.text = widget:get_children_by_id("text")[1]
widget.bar = widget:get_children_by_id("bar")[1]

local function usec2hms(usec)
  local h, m, s
  m, s = math.modf(usec / 60e6)
  s = math.floor(s * 60)
  h, m = math.modf(m / 60)
  m = math.floor(m * 60)
  return string.format("%02d:%02d:%02d", h, m, s)
end

local function metadata(playing)
  awful.spawn.easy_async_with_shell("playerctl metadata -f '{{playerName}}\n<b>{{artist}}</b> - {{title}}\n{{position}}/{{mpris:length}}'", function (stdout)
    if #stdout > 0 then
      if playing then
        widget.icon.image = beautiful.icon_music_play
      else
        widget.icon.image = beautiful.icon_music_pause
      end
      local p = string.split(string.trim(tostring(stdout)), "\n")
      local player = tostring(p[1] or "?")
      widget.text.visible = true
      widget.text.markup = p[2]
      local p = string.split(p[3], "/")
      if #p == 2 then
        local position = tonumber(p[1] or "0")
        local length = tonumber(p[2] or "0")
        widget.bar.visible = true
        widget.bar.span_ratio = position / length
        widget.tooltip.markup = markup.fg(beautiful.fg_focus, player) .. "\n" .. usec2hms(position) .. " / " .. usec2hms(length)
      end
    else
      widget.icon.image = beautiful.icon_music_off
      widget.text.visible = false
      widget.bar.visible = false
      widget.tooltip.markup = markup.italic("none")
    end
  end)
end

widget.update = function ()
  awful.spawn.easy_async_with_shell("playerctl status", function (stdout)
    if #stdout > 0 then
      metadata(string.trim(stdout) == "Playing")
    else
      widget.icon.image = beautiful.icon_music_off
      widget.text.visible = false
      widget.bar.visible = false
      widget.tooltip.markup = markup.italic("none")
    end
  end)
end

widget.tooltip = awful.tooltip {
  markup = markup.italic("none"),
  fg = beautiful.fg_normal,
  visible = false
}
tooltip(widget)

awful.widget.watch("true", 1, function () widget:update() end)

widget:buttons(gears.table.join(
  awful.button({}, mouse_left, function ()
    awful.spawn("playerctl play-pause") -- TODO start spotify?
  end)
))

globalkey { m = {}, k = "XF86AudioPlay", g = "media", d = "play-pause", f = function () awful.spawn("playerctl play-pause") end }
globalkey { m = {}, k = "XF86AudioPrev", g = "media", d = "previous", f = function () awful.spawn("playerctl previous") end }
globalkey { m = {}, k = "XF86AudioNext", g = "media", d = "next", f = function () awful.spawn("playerctl next") end }

return widget
