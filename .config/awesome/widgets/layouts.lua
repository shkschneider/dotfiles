local widget = wibox.widget.arc(beautiful.icon_loading)
widget.bar.visible = false

tooltip(widget)

widget.update = function ()
  local screen = awful.screen.focused()
  local layout = awful.layout.get(screen)
  local name = awful.layout.getname(layout)
  widget.icon.image = beautiful["layout_" .. name]
  widget.tooltip.markup = markup.fg(beautiful.fg_focus, name)
end

widget.update()

widget:buttons(gears.table.join(
  awful.button({}, mouse_left, function ()
    awful.layout.inc(1)
    widget.update()
  end),
  awful.button({}, mouse_right, function ()
    awful.layout.inc(-1)
    widget.update()
  end),
  awful.button({}, mouse_up, function ()
    awful.layout.inc(1)
    widget.update()
  end),
  awful.button({}, mouse_down, function ()
    awful.layout.inc(-1)
    widget.update()
  end),
  awful.button({}, mouse_middle, function ()
    awful.layout.set(awful.layout.layouts[1])
    widget.update()
  end)
))

return widget
