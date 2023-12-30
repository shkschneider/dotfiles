return function (id, settings)
    id = id or "bar"
    settings = settings or {}
    local widget = {
        id = id,
        min_value = settings.min_value or 0,
        value = settings.value or 0,
        max_value = settings.max_value or 100,
        forced_width = settings.width or settings.forced_width,
        forced_height = settings.height or settings.forced_height,
        shape = settings.shape or beautiful.shape,
        color = settings.color or beautiful.fg_normal,
        background_color = settings.background_color or beautiful.colors.black,
        widget = wibox.widget.progressbar
    }
    for k, v in pairs(settings) do
        widget[k] = v
    end
    return {
        widget,
        left = beautiful.margin, right = beautiful.margin,
        top = beautiful.padding, bottom = beautiful.padding,
        widget = wibox.container.margin
    }
end
