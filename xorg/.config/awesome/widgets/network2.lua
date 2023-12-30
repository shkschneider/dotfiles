local function _parse(out)
    local s = string.split(out, "\n")
    local t = {
        name = s[2],
        address = s[1],
        devices = {}
    }
    for i = 3, #s do
        table.insert(t.devices, s[i])
    end
    return t
end

local widget = wibox.widget {
    nice.widget.icon("network2_icon", nice.tint(beautiful.icons.radio, beautiful.fg_normal)),
    spacing = beautiful.padding,
    layout = wibox.layout.fixed.horizontal
}
widget.visible = false
widget.icon = widget:get_children_by_id("network2_icon")[1]

widget.popup = nice.popup(widget, {
    x = -(beautiful.margin + dpi(360) + beautiful.margin + beautiful.margin),
    y = beautiful.margin + dpi(32) + beautiful.margin,
    width = beautiful.margin + dpi(360) + beautiful.margin,
    height = beautiful.margin + dpi(24) + beautiful.margin,
    {
        {
            nice.widget.text("name", "", { align = "center" }),
            nice.widget.text("address", "", { align = "center" }),
            spacing = beautiful.padding,
            layout = wibox.layout.flex.horizontal
        },
        {
            id = "container",
            spacing = beautiful.padding,
            layout = wibox.layout.flex.vertical
        },
        spacing = beautiful.padding,
        layout = wibox.layout.align.vertical
    },
    margins = beautiful.margin,
    layout = wibox.container.margin
})
widget.popup.name = widget.popup.widget:get_children_by_id("name")[1]
widget.popup.address = widget.popup.widget:get_children_by_id("address")[1]
widget.popup.container = widget.popup.widget:get_children_by_id("container")[1]

widget.update = function (widget)
    nice.a.script("widgets/network2.sh", function (out)
        local t = _parse(out)
        if not t.address then
            widget.visible = false
            widget.popup:hide()
            return
        end
        widget.visible = true
        widget.popup.name.markup = markup.bold(t.name)
        widget.popup.address.markup = t.address
        widget.popup.container:reset()
        for _, device in ipairs(t.devices) do
            widget.popup.container:add(wibox.widget {
                nice.widget.text(nil, device, { align = "right" }),
                layout = wibox.layout.align.vertical
            })
        end
        widget.popup.widget.forced_height = beautiful.margin + dpi(24) + beautiful.margin
            + (#t.devices > 0 and dpi(24) * #t.devices + beautiful.padding * (#t.devices - 1) or 0)
    end)
end
nice.widget.update(widget, 6, widget.update)

nice.widget.button(widget, nice.mouse.left, function ()
    nice.a.script("network2.sh")
end)

return widget
