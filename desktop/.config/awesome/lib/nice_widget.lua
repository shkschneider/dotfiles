assert(awesome and awful and gears and wibox)

local function tooltip(widget)
    widget.tooltip = awful.tooltip {
        text = "...",
        fg = beautiful.fg_normal,
        visible = false
    }
    widget.tooltip:add_to_object(widget)
    widget:connect_signal("mouse::enter", function() widget.tooltip.visible = true end)
    widget:connect_signal("mouse::leave", function() widget.tooltip.visible = false end)
end

local function button(widget, button, f)
    widget:buttons(gears.table.join(widget:buttons(), awful.button({}, button, f)))
end

local function update(widget, seconds, f)
    awful.widget.watch("true", seconds, function () f(widget) end)
    f(widget)
end

local function popup(widget, popup)
    assert(popup.widget and popup.widget.forced_width and popup.widget.forced_height)
    widget.popup = popup
    widget.popup.show = function (_, timeout)
        timeout = timeout or 1
        assert(timeout >= 0)
        widget.popup.visible = true
        if widget.popup.timer then widget.popup.timer:stop() end
        if timeout > 0 then
            widget.popup.timer = gears.timer {
                timeout = timeout,
                call_now = false,
                autostart = true,
                callback = function ()
                    widget.popup:hide()
                end
            }
        end
    end
    widget.popup.hide = function (_, now)
        if widget.popup.timer then widget.popup.timer:stop() end
        widget.popup.visible = false
    end
    widget:connect_signal("mouse::enter", function()
        widget.popup:show(0)
    end)
    widget:connect_signal("mouse::leave", function()
        widget.popup:hide()
    end)
end

return {
    tooltip = tooltip,
    button = button,
    update = update,
    popup = popup,
    text = require "lib.nice_widget_text",
    icon = require "lib.nice_widget_icon",
    bar = require "lib.nice_widget_bar",
    slider = require "lib.nice_widget_slider",
    arc = require "lib.nice_widget_arc",
    space = require "lib.nice_widget_space",
    center = function (widget)
        return {
            widget,
            widget = wibox.container.place
        }
    end
}
