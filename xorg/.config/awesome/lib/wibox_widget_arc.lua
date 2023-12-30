local wibox = require "wibox"

return function (icon)
    local widget = wibox.widget {
        {
            {
                id = "icon",
                image = icon or nil,
                resize = true,
                widget = wibox.widget.imagebox
            },
            margins = dpi(4),
            layout = wibox.container.margin
        },
        {
            {
                id = "bar",
                value = 0,
                max_value = 100,
                thickness = dpi(2),
                start_angle = 0, --math.pi
                rounded_edge = true,
                paddings = 0,
                bg = nil,
                colors = { beautiful.fg_focus },
                widget = wibox.container.arcchart
            },
            margins = dpi(2),
            layout = wibox.container.margin
        },
        layout = wibox.layout.stack,
    }
    widget.bar = widget:get_children_by_id("bar")[1]
    widget.icon = widget:get_children_by_id("icon")[1]
    return widget
end
