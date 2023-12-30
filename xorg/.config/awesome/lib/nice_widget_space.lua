return function (width, height)
    return wibox.widget {
        forced_width = width or 1,
        forced_height = height or 1,
        span_ratio = 0,
        widget = wibox.widget.separator
    }
end
