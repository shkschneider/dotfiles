assert(awesome and awful and beautiful)

local function titlebars(c)
    -- if c.type == "dialog" or ... then
	awful.titlebar(c, {
	    position = "left",
	    bg = beautiful.bg_normal,
	    size = dpi(24)
    }):setup {
        {
            awful.titlebar.widget.closebutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.minimizebutton(c),
            layout  = wibox.layout.fixed.vertical
        },
        {
            buttons = gears.table.join(),
            layout = wibox.layout.fixed.vertical
        },
        {
            awful.widget.clienticon(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.floatingbutton(c),
            layout = wibox.layout.fixed.vertical
        },
        layout = wibox.layout.align.vertical
    }
    -- awful.titlebar.show/hide "left"
end

client.connect_signal("request::titlebars", titlebars)
-- client.connect_signal("manage", titlebars)

-- focus at spawn
client.connect_signal("manage", function (c)
    c:move_to_screen((c.focus or mouse).screen)
    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
    -- titlebars(c)
end)

-- borders
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- not always with borders
screen.connect_signal("arrange", function (s)
    for _, c in pairs(s.clients) do
        if c.floating or c.sticky then
            c.border_color = beautiful.border_marked
            c.border_width = 1
        elseif c.maximized or c.fullscreen or #s.clients == 1 then
            c.border_width = 0
        elseif c.focused then
            c.border_color = beautiful.border_focus
            c.border_width = 1
        else
            c.border_color = beautiful.border_normal
            c.border_width = 1
        end
    end
end)

clientkey { m = { super }, k = "f", g = "windows", d = "fullscreen", f = function (c)
    c.fullscreen = not c.fullscreen
    c:raise()
end }
clientkey { m = { super, control }, k = "t", g = "windows", d = "on top", f = function (c)
    c.ontop = not c.ontop
end }
clientkey { m = { super, control }, k = "s", g = "windows", d = "sticky", f = function (c)
    c.sticky = not c.sticky
end }
clientkey { m = { super, control }, k = "f", g = "windows", d = "floating", f = function (c)
    awful.client.floating.toggle(c)
    -- if c.floating then
        -- awful.titlebar.show(c)
    -- else
        -- awful.titlebar.hide(c)
    -- end
    if #c.screen.tiled_clients >= 1 then
        awful.placement.centered(c, nil)
        c:raise()
    end
end }

-- open/close

clientkey { m = { super }, k = "q", g = "windows", d = "kill", f = function (c) c:kill() end }
