local function _callback(widget, tag, i, _)
    local fg = widget:get_children_by_id("tags_text")[1]
    local bg = widget:get_children_by_id("tags_background")[1]
    if tag.selected then
        if #tag:clients() > 0 then
            fg.markup = markup.bold(markup.underline(markup.fg(beautiful.fg_focus, tag.name)))
        else
            fg.markup = markup.bold(markup.underline(tag.name))
        end
        bg.bg = nil
    elseif #tag:clients() > 0 then
        fg.markup = markup.fg(beautiful.fg_focus, tag.name)
        bg.bg = nil
    else
        fg.text = tag.name
        bg.bg = nil
    end
end

return function (s)
    return awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        widget_template = {
            {
                {
                    id = "tags_text",
                    widget = wibox.widget.textbox
                },
                margins = beautiful.padding,
                widget = wibox.container.margin
            },
            id = "tags_background",
            bg = nil,
            shape = gears.shape.circle,
            widget = wibox.container.background,
            create_callback = _callback,
            update_callback = _callback
        },
        buttons = awful.util.table.join(
            awful.button({}, nice.mouse.left, function(t) t:view_only() end),
            awful.button({ super }, nice.mouse.left, function(t) if client.focus then client.focus:move_to_tag(t) end end),
            awful.button({}, nice.mouse.right, awful.tag.viewtoggle),
            awful.button({ super }, nice.mouse.right, function(t) if client.focus then client.focus:toggle_tag(t) end end),
            awful.button({}, nice.mouse.up, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
            awful.button({}, nice.mouse.down, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
        )
    }
end
