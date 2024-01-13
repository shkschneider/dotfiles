local function _parse(out)
    local s = string.split(out, "\n")
    local t = {}
    for _, ss in ipairs(s) do
        table.insert(t, string.split(ss, " "))
    end
    return t
end

local widget = nice.widget.arc("storage_arc", nice.widget.icon("storage_icon", nice.tint(beautiful.icons.hard_drive, beautiful.fg_normal)))
widget.arc = widget:get_children_by_id("storage_arc")[1]
widget.icon = widget:get_children_by_id("storage_icon")[1]

widget.popup = nice.popup(widget, {
    x = -(beautiful.margin + dpi(360) + beautiful.margin + beautiful.margin),
    y = beautiful.margin + dpi(32) + beautiful.margin,
    width = beautiful.margin + dpi(360) + beautiful.margin,
    height = beautiful.margin + dpi(24) + beautiful.margin,
    {
        id = "container",
        spacing = beautiful.padding,
        layout = wibox.layout.flex.vertical
    },
    margins = beautiful.margin,
    layout = wibox.container.margin
})
widget.popup.container = widget.popup.widget:get_children_by_id("container")[1]

widget.update = function (widget)
    nice.a.script("widgets/storage.sh", function (out)
        local t = _parse(out)
        widget.arc.value = tonumber(t[1][2])
        widget.popup.container:reset()
        -- for _, child in ipairs(widget.popup.container.children) do
            -- widget.popup.container:remove(child)
        -- end
        for _, tt in ipairs(t) do
            widget.popup.container:add(wibox.widget {
                nice.widget.text(nil, tt[1]),
                {
                    nice.widget.bar(tt[1] .. "_bar", { value = tonumber(tt[2]) }),
                    direction = "south",
                    layout = wibox.container.rotate
                },
                nice.widget.text(nil, tt[2] .. "%"),
                forced_height = dpi(24),
                layout = wibox.layout.align.horizontal
            })
        end
        widget.popup.widget.forced_height = beautiful.margin + dpi(24) * #t + beautiful.padding * (#t - 1) + beautiful.margin
    end)
end
nice.widget.update(widget, 60 * 60, widget.update)

return widget
