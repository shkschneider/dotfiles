assert(awesome and awful and gears)

return function (parent, widget)
    widget.forced_width = widget.forced_width or widget.width
    widget.forced_height = widget.forced_height or widget.height
    -- assert(widget.forced_width and widget.forced_height)
    if widget.x and widget.x < 0 then widget.x = awful.screen.focused().geometry.width + widget.x end
    if widget.y and widget.y < 0 then widget.y = awful.screen.focused().geometry.height + widget.y end
    assert(widget.widget or widget.layout)
    local popup = awful.popup {
        type = "popup_menu",
        widget = widget,
        x = widget.x,
        y = widget.y,
        placement = widget.placement,
        shape = beautiful.shape,
        ontop = true,
        visible = false
    }
    assert(popup.placement or (popup.x and popup.y))
    -- popup.get = function (self, id, nth) TODO remove
        -- assert(id)
        -- return popup.widget:get_children_by_id(id)[nth or 1]
    -- end
    popup.show = function (self, timeout)
        timeout = timeout or 1
        assert(timeout >= 0)
        self.visible = true
        if self.timer and self.timer.started then self.timer:stop() end
        if timeout > 0 then
            self.timer = gears.timer {
                timeout = timeout,
                call_now = false,
                autostart = true,
                callback = function ()
                    self:hide()
                end
            }
        end
    end
    popup.hide = function (self)
        if self.timer and self.timer.started then self.timer:stop() end
        self.visible = false
    end
    if parent then
        assert(parent.connect_signal)
        parent:connect_signal("mouse::enter", function()
            popup:show(0)
        end)
        parent:connect_signal("mouse::leave", function()
            popup:hide()
        end)
    end
    return popup
end
