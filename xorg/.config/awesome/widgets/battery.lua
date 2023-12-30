local function _parse(out)
    local s = string.split(out, "\n")
    local t = {}
    for _, ss in ipairs(s) do
        table.insert(t, string.split(ss, " "))
    end
    return t
end

local widget = nice.widget.arc("battery_arc", nice.widget.icon("battery_icon", nice.tint(beautiful.icons.zap_off, beautiful.fg_normal)))
widget.arc = widget:get_children_by_id("battery_arc")[1]
widget.icon = widget:get_children_by_id("battery_icon")[1]
widget.visible = false

widget.popup = nice.popup(widget, {
    x = -(beautiful.margin + dpi(360) + beautiful.margin + beautiful.margin),
    y = beautiful.margin + dpi(32) + beautiful.margin,
    width = beautiful.margin + dpi(360) + beautiful.margin,
    height = beautiful.margin + dpi(24) + beautiful.margin,
    {
        nice.widget.icon("battery_icon", nice.tint(beautiful.icons.zap_off, beautiful.fg_normal)),
        {
            nice.widget.bar("battery_bar"),
            direction = "south",
            layout = wibox.container.rotate
        },
        nice.widget.text("battery_value", "%"),
        layout = wibox.layout.align.horizontal
    },
    margins = beautiful.margin,
    widget = wibox.container.margin
})
widget.popup.icon = widget.popup.widget:get_children_by_id("battery_icon")[1]
widget.popup.bar = widget.popup.widget:get_children_by_id("battery_bar")[1]
widget.popup.bar_value = widget.popup.widget:get_children_by_id("battery_value")[1]

widget.update = function (widget)
    nice.a.script("widgets/battery.sh", function (out)
        local t = _parse(out)
        if #t == 0 then
            widget.visible = false
            widget.tooltip.visible = false
        else
            widget.visible = true
            local n, charge, status = t[1][1], tonumber(t[1][2]), string.trim(t[1][3])
            if status == "charging" or status == "full" then
                widget.icon.image = nice.tint(beautiful.icons.zap, beautiful.fg_normal)
                widget.popup.icon.image = nice.tint(beautiful.icons.zap, beautiful.fg_normal)
            else
                widget.icon.image = nice.tint(beautiful.icons.zap_off, beautiful.fg_normal)
                widget.popup.icon.image = nice.tint(beautiful.icons.zap_off, beautiful.fg_normal)
            end
            widget.arc.opacity = charge > 75 and 0.5 or 1.0
            --widget.arc.colors = { (charge < 25 and beautiful.fg_urgent or beautiful.fg_focus) }
            widget.arc.value = charge
            widget.popup.bar.value = charge
            widget.popup.bar_value.text = tostring(charge) .. "%"
            --widget.popup.bar.color = (charge < 25 and beautiful.fg_urgent or beautiful.fg_normal)
        end
    end)
end
nice.widget.update(widget, 60, widget.update)

return widget
