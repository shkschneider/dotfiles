local step = 5

-- widget

local widget = wibox.widget.arc(beautiful.icon_volume_up)

widget.volume = 0

widget.increase = function ()
  if widget.volume == 0 then widget:mute() end
  if widget.volume == 100 then return end
  widget.volume = widget.volume + step
  if widget.volume > 100 then widget.volume = 100 end
  --awful.spawn("pamixer --increase " .. step)
  widget:update()
end

widget.decrease = function ()
  if widget.volume == 0 then return end
  widget.volume = widget.volume - step
  if widget.volume < 0 then widget.volume = 0 end
  --awful.spawn("pamixer --decrease " .. step)
  widget:update()
end

widget.update = function ()
  if widget.volume > 0 then
    awful.spawn("pamixer --set-volume " .. widget.volume)
  end
  widget.bar.value = widget.volume
  if widget.volume == 0 then
    widget.bar.opacity = 0
    widget.icon.image = beautiful.icon_volume_mute
  else
    widget.bar.opacity = 1
    widget.icon.image = beautiful.icon_volume_up
  end
  widget.tooltip.update(widget.volume)
end

widget.mute = function ()
  awful.spawn("pamixer --toggle-mute")
  if widget.volume > 0 then
    widget.volume = 0
    widget:update()
  else
    widget.volume = 1
    widget:refresh()
  end
end

widget.refresh = function (self)
  awful.spawn.easy_async_with_shell("pamixer --get-volume", function (stdout)
    widget.volume = tonumber(stdout)
    widget:update()
  end)
end

-- tooltip

widget.tooltip = awful.tooltip {
  text = "...",
  fg = beautiful.fg_normal,
  visible = false
}
widget.tooltip.update = function (v)
  widget.tooltip.markup = markup.bold(markup.fg(beautiful.fg_focus, tostring(math.floor(v))) .. "%")
end
tooltip(widget)

-- return

globalkey { m = {}, k = "XF86AudioRaiseVolume", g = "media", d = "increase", f = function () widget:increase() end }
globalkey { m = {}, k = "XF86AudioLowerVolume", g = "media", d = "decrease", f = function () widget:decrease() end }
globalkey { m = {}, k = "XF86AudioMute", g = "media", d = "output mute", f = function () widget:mute() end }
globalkey { m = {}, k = "XF86AudioMicMute", g = "media", d = "input mute", f = function ()
  -- pamixer --default-source --toggle-mute
end }

widget:buttons(gears.table.join(
  awful.button({}, mouse_up, function () widget:increase() end),
  awful.button({}, mouse_down, function () widget:decrease() end),
  awful.button({}, mouse_left, function () widget:mute() end)
))

widget:refresh()

return widget
