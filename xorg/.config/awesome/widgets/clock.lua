local widget = wibox.widget.textclock("%H:%M")

nice.widget.update(widget, 3600 / 2, function (widget)
    nice.wallpaper()
end)

local args = {
    position = "br", -- FIXME bad offset
    screen = mouse.screen,
    opacity = beautiful.opacity,
    week_numbers = true,
    start_sundays = false,
    long_weekdays = true,
    style_month = {
        fg_color = beautiful.fg_normal,
        bg_color = beautiful.bg_normal,
        border_width = 0
    },
    style_header = {
        fg_color = beautiful.fg_focus,
        bg_color = beautiful.bg_focus,
        border_width = 0
    },
    style_weekday = {
        fg_color = beautiful.fg_normal,
        bg_color = beautiful.bg_normal,
        border_width = 0
    },
    style_weeknumber = {
        fg_color = beautiful.fg_normal,
        bg_color = beautiful.bg_normal,
        border_width = 0
    },
    style_normal = {
        fg_color = beautiful.fg_normal,
        bg_color = beautiful.bg_normal,
        border_width = 0
    },
    style_focus = {
        fg_color = beautiful.fg_normal,
        bg_color = beautiful.bg_normal,
        border_width = 1,
        border_color = beautiful.fg_focus
    }
}

local calendar = awful.widget.calendar_popup.month(args)
widget:connect_signal("mouse::enter", function ()
    calendar.screen = mouse.screen
    calendar:toggle()
end)
widget:connect_signal("mouse::leave", function ()
    calendar:toggle()
end)

return widget
