return function (id, image, settings)
    id = id or "icon"
    settings = settings or {}
    if not image then
        awesome.emit_signal("debug::deprecation", tostring(id) .. ": invalid image")
    end
    local widget = {
        id = id,
        image = image,
        width = settings.width or settings.size or dpi(96),
        height = settings.height or settings.size or dpi(96),
        forced_width = settings.width or settings.size,
        forced_height = settings.height or settings.size,
        resize = settings.resize or settings.size == nil,
        auto_dpi = true,
        widget = wibox.widget.imagebox
    }
    for k, v in pairs(settings) do
        widget[k] = v
    end
    return widget
end
