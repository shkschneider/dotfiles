-- FIXME
return function (id, settings)
    id = id or "slider"
    settings = settings or {}
    local bar = {
        id = id .. "_bar",
        nice.widget.bar(nil, {
            min_value = settings.minimum or settings.min_value or 0,
            value = settings.value or 0,
            max_value = settings.maximum or settings.max_value or 100,
            height = dpi(4),
            color = settings.background_color or beautiful.fg_normal,
            background_color = beautiful.colors.null,
        }),
        top = dpi(4 + 2), bottom = dpi(2 + 4),
        layout = wibox.container.margin
    }
    local handle = {
        id = id .. "_handle",
        value = settings.value or 0,
        minimum = settings.minimum or 0,
        maximum = settings.maximum or 100,
        bar_shape = gears.shape.rounded_rect,
        bar_height = dpi(4),
        bar_color = beautiful.colors.null,
        -- FIXME not working, see progressbar above
        bar_active_color = settings.color or beautiful.fg_focus,
        handle_color = settings.color or beautiful.fg_focus,
        handle_width = dpi(8),
        handle_shape = gears.shape.circle,
        handle_border_color = settings.color or beautiful.fg_focus,
        handle_border_width = beautiful.border_width,
        widget = wibox.widget.slider
    }
    for k, v in pairs(settings) do
        bar[k] = v
        handle[k] = v
    end
    -- FIXME
    -- handle.connect_signal("widget::redraw_needed", function ()
        -- bar.value = 99
    -- end)
    return {
        bar,
        handle,
        forced_width = settings.width or settings.forced_width,
        forced_height = settings.height or settings.forced_height or dpi(24),
        layout = wibox.layout.stack
    }
end
