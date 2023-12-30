return function (id, content, settings)
    id = id or "arc"
    assert(content == nil or (content.widget or content.layout or content.children))
    settings = settings or {}
    local widget = {
        id = id,
        min_value = settings.min_value or 0,
        value = settings.value or 0,
        max_value = settings.max_value or 100,
        thickness = settings.thickness or dpi(2),
        start_angle = settings.start_angle or (3 * math.pi / 2),
        rounded_edge = settings.rounded_edge or true,
        paddings = settings.paddings or 0,
        bg = nil,
        colors = { beautiful.fg_focus },
        widget = wibox.container.arcchart
    }
    for k, v in pairs(settings) do
        widget[k] = v
    end
    widget.forced_width = settings.size
    widget.forced_height = settings.size
    return wibox.widget {
        {
            content, -- and nice.widget.center(content),
            margins = settings.paddings or beautiful.padding,
            layout = wibox.container.margin
        },
        widget,
        layout = wibox.layout.stack
    }
end
