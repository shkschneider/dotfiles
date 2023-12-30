assert(awesome and awful and gears)

return function (content, settings)
    settings = settings or {}
    local screen = awful.screen.focused()
    content.forced_width = content.forced_width or content.width or content.size
    content.forced_height = content.forced_height or content.height or content.size
    assert(content.forced_width and content.forced_height)
    local splash = awful.popup {
        type = "splash",
        x = 0, y = 0,
        width = screen.geometry.width,
        height = screen.geometry.height,
        widget = {
            x = 0, y = 0,
            nice.widget.space(screen.geometry.width, screen.geometry.height),
            layout = wibox.container.place
        },
        bg = beautiful.colors.null,
        ontop = true,
        visible = false
    }
    splash.popup = awful.popup {
        type = "dock",
        x = screen.geometry.width / 2 - content.forced_width / 2,
        y = screen.geometry.height / 2 - content.forced_height / 2,
        width = awful.screen.focused().geometry.width - (beautiful.margin) * 2,
        height = awful.screen.focused().geometry.height - (beautiful.margin + dpi(32) + beautiful.margin) * 2,
        widget = content,
        bg = settings.bg or beautiful.colors.null,
        shape = beautiful.shape,
        ontop = true,
        visible = false
    }
    splash.toggle = function (self)
        self.visible = not self.visible
        self.popup.visible = self.visible
    end
    splash:buttons(gears.table.join(
        awful.button({}, nice.mouse.left, function () splash:toggle() end),
        awful.button({}, nice.mouse.right, function () splash:toggle() end)
    ))
    return splash
end
