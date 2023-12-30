return function (id, markup, settings)
    id = id or "text"
    settings = settings or {}
    local widget = {
        id = id,
        markup = markup,
        widget = wibox.widget.textbox
    }
    for k, v in pairs(settings) do
        widget[k] = v
    end
    return widget
end
