local function _parse(out)
    local s = string.split(out, "\n")
    local t = {}
    for _, ss in ipairs(s) do
        local sss = string.split(ss, " ")
        table.insert(t, {
            interface = tostring(sss[1]),
            type = tostring(sss[2]),
            status = tostring(sss[3]),
            address = tostring(sss[4]),
            received = tonumber(sss[5]),
            sent = tonumber(sss[6]),
            name = ss:sub(ss:find('"') + 1, -2)
        })
    end
    return t
end

local widget = wibox.widget {
    nice.widget.icon("network_icon", nice.tint(beautiful.icons.wifi_off, beautiful.fg_normal)),
    nice.widget.text("network_text", "?↓↑?"),
    spacing = beautiful.padding,
    layout = wibox.layout.fixed.horizontal
}
widget.icon = widget:get_children_by_id("network_icon")[1]
widget.text = widget:get_children_by_id("network_text")[1]

widget.popup = nice.popup(widget, {
    x = -(beautiful.margin + dpi(360) + beautiful.margin + beautiful.margin),
    y = beautiful.margin + dpi(32) + beautiful.margin,
    width = beautiful.margin + dpi(360) + beautiful.margin,
    height = beautiful.margin + dpi(24) + beautiful.margin,
    {
        id = "network_container",
        spacing = beautiful.padding,
        layout = wibox.layout.flex.vertical
    },
    margins = beautiful.margin,
    layout = wibox.container.margin
})
widget.popup.container = widget.popup.widget:get_children_by_id("network_container")[1]

widget.data = {
    received = 0,
    sent = 0
}

widget.update = function (widget)
    nice.a.script("widgets/network.sh", function (out)
        local t = _parse(out)
        widget.popup.container:reset()
        for i, tt in ipairs(t) do
            if i == 1 then
                widget.icon.image = nice.tint(tt.status == "up" and beautiful.icons.wifi or beautiful.icons.wifi_off, beautiful.fg_normal)
                if tt.received < 0 then tt.received = widget.data.received end
                if tt.sent < 0 then tt.sent = widget.data.sent end
                widget.text.text = nice.pretty.size(tt.received - widget.data.received) .. "↓↑" .. nice.pretty.size(tt.sent - widget.data.sent)
                widget.data.received = tt.received
                widget.data.sent = tt.sent
            end
            local l1 = tt.type .. ": " .. tt.interface .. "\n" .. "[" .. tt.status .. "]"
            local l2 = tt.address .. "\n" .. '"' .. tt.name .. '"'
            widget.popup.container:add(wibox.widget {
                nice.widget.text(nil, tt.status == "up" and markup.bold(l1) or l1, { align = "center" }),
                nice.widget.text(nil, tt.status == "up" and markup.bold(l2) or l2, { align = "center" }),
                layout = wibox.layout.flex.horizontal
            })
        end
        widget.popup.widget.forced_height = beautiful.margin + beautiful.margin + dpi(24) * #t + beautiful.padding * math.clamp(#t - 1, 0, #t)
    end)
end
nice.widget.update(widget, 6, widget.update)

nice.widget.button(widget, nice.mouse.left, function ()
    nice.a.script("network.sh")
end)

return widget
