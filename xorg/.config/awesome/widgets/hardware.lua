local function _parse(out)
    local s = string.split(out, "\n")
    local s1 = string.split(s[1], " ")
    local s2 = string.split(s[2], " ")
    return {
        cpu_percentage = tonumber(s1[1]),
        cpu_n = tonumber(s1[2]),
        cpu_loadavg = table.concat({s1[3], s1[4], s1[5]}, " "),
        ram_percentage = tonumber(s2[1]),
        ram_total = tonumber(s2[2])
    }
end

local widget = wibox.widget {
    nice.widget.arc("hardware_cpu", nil, { thickness = dpi(2), colors = { beautiful.fg_focus }, start_angle = 0 }),
    nice.widget.arc("hardware_ram", nil, { thickness = dpi(1), colors = { beautiful.fg_normal }, start_angle = math.pi }),
    {
        nice.widget.icon("hardware_icon", nice.tint(beautiful.icons.cpu, beautiful.fg_normal)),
        margins = beautiful.padding,
        layout = wibox.container.margin
    },
    layout = wibox.layout.stack
}
widget.cpu = widget.children[1]:get_children_by_id("hardware_cpu")[1]
widget.ram = widget.children[2]:get_children_by_id("hardware_ram")[1]

widget.popup = nice.popup(widget, {
    x = -(beautiful.margin + dpi(360) + beautiful.margin + beautiful.margin),
    y = beautiful.margin + dpi(32) + beautiful.margin,
    width = beautiful.margin + dpi(360) + beautiful.margin,
    height = beautiful.margin + dpi(24) + beautiful.padding + dpi(24) + beautiful.margin,
    {
        {
            nice.widget.text(nil, "CPU"),
            {
                nice.widget.bar("cpu_bar"),
                direction = "south",
                layout = wibox.container.rotate
            },
            nice.widget.text("cpu_text", "%"),
            layout = wibox.layout.align.horizontal
        },
        {
            nice.widget.text(nil, "RAM"),
            {
                nice.widget.bar("ram_bar"),
                direction = "south",
                layout = wibox.container.rotate
            },
            nice.widget.text("ram_text", "%"),
            layout = wibox.layout.align.horizontal
        },
        layout = wibox.layout.flex.vertical
    },
    margins = beautiful.margin,
    layout = wibox.container.margin
})
widget.popup.cpu_bar = widget.popup.widget:get_children_by_id("cpu_bar")[1]
widget.popup.cpu_text = widget.popup.widget:get_children_by_id("cpu_text")[1]
widget.popup.ram_bar = widget.popup.widget:get_children_by_id("ram_bar")[1]
widget.popup.ram_text = widget.popup.widget:get_children_by_id("ram_text")[1]

widget.update = function (widget)
    nice.a.script("widgets/hardware.sh", function (out)
        local t = _parse(out)
        widget.cpu.value = t.cpu_percentage / 2
        -- widget.cpu.opacity = t.cpu_percentage / 50
        -- widget.cpu.colors = { (t.cpu_percentage > 75 and beautiful.fg_urgent or beautiful.fg_focus) }
        widget.ram.value = t.ram_percentage / 2
        -- widget.ram.opacity = t.ram_percentage / 50
        -- widget.ram.colors = { (t.ram_percentage > 75 and beautiful.fg_urgent or beautiful.fg_focus) }
        widget.popup.cpu_bar.value = t.cpu_percentage
        widget.popup.cpu_text.markup = tostring(t.cpu_percentage) .. "%"
        widget.popup.ram_bar.value = t.ram_percentage
        widget.popup.ram_text.markup = tostring(t.ram_percentage) .. "%"
    end)
end

nice.widget.update(widget, 6, widget.update)

return widget
