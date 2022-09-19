local widget = wibox.widget.textclock("%H:%M")

local calendar = awful.widget.calendar_popup.month {
  position = "tr",
  screen = awful.screen.focused(), -- FIXME mouse.screen
  opacity = beautiful.opacity,
  week_numbers = true,
  start_sundays = false,
  long_weekdays = true,
  style_month = {
    fg_color = beautiful.fg_focus,
    bg_color = beautiful.bg_focus,
    border_width = 0
  },
  style_header = {
    fg_color = beautiful.fg_urgent,
    bg_color = beautiful.bg_urgent,
    border_width = 0
  },
  style_weekday = {
    fg_color = beautiful.fg_focus,
    bg_color = beautiful.bg_focus,
    border_width = 0
  },
  style_weeknumber = {
    fg_color = beautiful.fg_focus,
    bg_color = beautiful.bg_focus,
    border_width = 0
  },
  style_normal = {
    fg_color = beautiful.fg_normal,
    bg_color = beautiful.bg_normal,
    border_width = 0
  },
  style_focus = {
    fg_color = beautiful.fg_urgent,
    bg_color = beautiful.bg_urgent,
    border_width = 1,
    border_color = beautiful.bg_focus
  }
}

widget:connect_signal("mouse::enter", function ()
  --calendar:attach(widget)
  calendar:toggle()
end)
widget:connect_signal("mouse::leave", function ()
  calendar:toggle()
end)

-- TODO button mouse: next/prev month

return widget
