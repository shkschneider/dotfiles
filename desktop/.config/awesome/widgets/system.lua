local function _parse(out)
    local s = string.split(out, "\n")
    local t = {
        name = s[1] or "system",
        logo = nice.tint(s[2] or beautiful.icons.octagon, beautiful.fg_normal),
        updates = {}
    }
    for i = 3, #s do
        table.insert(t.updates, s[i])
    end
    return t
end

local widget = wibox.widget {
    nice.widget.icon("system_icon", nice.tint(beautiful.icons.octagon, beautiful.fg_normal)),
    margins = beautiful.padding,
    layout = wibox.container.margin
}
widget.icon = widget:get_children_by_id("system_icon")[1]

widget.popup = nice.popup(widget, {
    x = -(beautiful.margin + dpi(196) + beautiful.margin + beautiful.margin),
    y = beautiful.margin + dpi(32) + beautiful.margin,
    width = beautiful.margin + dpi(196) + beautiful.margin,
    height = beautiful.margin + dpi(24) + beautiful.padding + dpi(24) + beautiful.margin,
    {
        {
            nice.widget.text("system_host", markup.bold(os.getenv("USER")), { align = "right" }),
            nice.widget.space(1, beautiful.padding),
            nice.widget.text("system_status", os.getenv("HOSTNAME"), { align = "right" }),
            layout = wibox.layout.align.vertical
        },
        {
            id = "system_container",
            layout = wibox.layout.flex.vertical
        },
        layout = wibox.layout.align.vertical
    },
    margins = beautiful.margin,
    layout = wibox.container.margin
})
widget.popup.host = widget.popup.widget:get_children_by_id("system_host")[1]
widget.popup.status = widget.popup.widget:get_children_by_id("system_status")[1]
widget.popup.container = widget.popup.widget:get_children_by_id("system_container")[1]

widget.update = function (widget)
    nice.a.script("widgets/system.sh", function (out)
        local t = _parse(out)
        widget.popup.container:reset()
        if #t.updates > 0 then
            widget.icon.image = nice.tint(beautiful.icons.x_octagon, beautiful.fg_focus)
            widget.popup.host.markup = markup.bold(t.name)
            local updates = tostring(#t.updates) .. " update" .. (#t.updates > 1 and "s" or "")
            widget.popup.status.markup = markup.fg(beautiful.fg_focus, updates)
            widget.popup.container:add(nice.widget.space(1, beautiful.padding))
            for _, tt in ipairs(t.updates) do
                widget.popup.container:add(wibox.widget {
                    nice.widget.text(nil, tt, { align = "right" }),
                    layout = wibox.layout.align.vertical
                })
            end
            widget.popup.widget.forced_height = beautiful.margin + dpi(24) + beautiful.padding + dpi(24) + beautiful.margin
                + ((#t.updates > 0) and (beautiful.padding + dpi(24) * #t.updates) or 0)
        else
            widget.icon.image = nice.tint(t.logo, beautiful.fg_normal)
            widget.popup.host.markup = markup.bold(t.name)
            widget.popup.status.markup = markup.italic("up-to-date")
        end
    end)
end
nice.widget.update(widget, 6 * 60 * 60, widget.update)

nice.widget.button(widget, nice.mouse.left, function ()
    nice.a.script("powermenu.sh")
end)

return widget
