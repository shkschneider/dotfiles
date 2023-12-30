local widget = wibox.widget {
    nice.widget.icon("layouts_icon", nice.tint(beautiful.icons.layout, beautiful.fg_normal)),
    margins = beautiful.padding,
    layout = wibox.container.margin
}
widget.icon = widget:get_children_by_id("layouts_icon")[1]

widget.popup = nice.popup(widget, {
    x = -(beautiful.margin + dpi(196) + beautiful.margin + beautiful.margin),
    y = beautiful.margin + dpi(32) + beautiful.margin,
    width = (beautiful.margin + dpi(196) + beautiful.margin),
    height = beautiful.margin + dpi(32) * #awful.layout.layouts + beautiful.margin,
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
    local current = awful.layout.getname(awful.layout.get(awful.screen.focused()))
    widget.icon.image = nice.tint(
        beautiful.icons["layout_" .. current] or beautiful["layout_" .. current] or beautiful.icons.layout,
        beautiful.fg_normal
    )
    widget.popup.container:reset()
    for _, layout in ipairs(awful.layout.layouts) do
        local name = awful.layout.getname(layout)
        widget.popup.container:add(wibox.widget {
            nice.widget.text(nil,
                markup.fg(name == current and beautiful.fg_focus or beautiful.fg_normal, name),
                { align = "right", forced_width = dpi(196) - beautiful.padding * 2 - dpi(16) }
            ),
            nice.widget.space(beautiful.padding),
            {
                nice.widget.icon(
                    nil,
                    nice.tint(
                        beautiful.icons["layout_" .. name] or beautiful["layout_" .. name] or beautiful.icons.layout,
                        beautiful.fg_normal
                    ),
                    { forced_width = dpi(16), forced_height = dpi(16) }
                ),
                top = dpi(8),
                layout = wibox.container.margin
            },
            layout = wibox.layout.align.horizontal
        })
    end
    widget.popup:show()
end
widget:update()

nice.widget.button(widget, nice.mouse.left, function ()
    awful.layout.inc(1)
    widget:update()
end)
nice.widget.button(widget, nice.mouse.up, function ()
    awful.layout.inc(1)
    widget:update()
end)
nice.widget.button(widget, nice.mouse.right, function ()
    awful.layout.inc(-1)
    widget:update()
end)
nice.widget.button(widget, nice.mouse.down, function ()
    awful.layout.inc(-1)
    widget:update()
end)
nice.widget.button(widget, nice.mouse.middle, function ()
    awful.layout.set(awful.layout.layouts[1])
    widget:update()
end)

for _, tag in ipairs(root.tags()) do
    awful.screen.focused():connect_signal("property::layout", widget.update)
end

return widget
