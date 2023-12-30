local widget = nice.widget.arc("volume_arc", nice.widget.icon("volume_icon", nice.tint(beautiful.icons.volume_2, beautiful.fg_normal)))
widget.arc = widget:get_children_by_id("volume_arc")[1]
widget.icon = widget:get_children_by_id("volume_icon")[1]

widget.popup = nice.popup(widget, {
    x = beautiful.margin,
    y = beautiful.margin + dpi(32) + beautiful.margin,
    width = beautiful.margin + dpi(360) + beautiful.margin,
    height = beautiful.margin + dpi(24) + beautiful.margin,
    {
        nice.widget.icon("volume_icon", nice.tint(beautiful.icons.volume, beautiful.fg_normal)),
        nice.widget.bar("volume_bar"),
        {
            id = "volume_value",
            text = "%",
            widget = wibox.widget.textbox
        },
        layout = wibox.layout.align.horizontal
    },
    margins = beautiful.margin,
    widget = wibox.container.margin
})
widget.popup.icon = widget.popup.widget:get_children_by_id("volume_icon")[1]
widget.popup.bar = widget.popup.widget:get_children_by_id("volume_bar")[1]
widget.popup.value = widget.popup.widget:get_children_by_id("volume_value")[1]

widget.data = {
    STEP = 5,
    volume = 0,
    muted = false,
}

widget.update = function(widget)
    widget.arc.value = widget.data.volume
    widget.arc.opacity = widget.data.volume > 0 and 1 or 0
    widget.popup.bar.value = widget.data.volume
    if widget.data.muted then
        -- widget.arc.opacity = 0.5
        widget.icon.image = nice.tint(beautiful.icons.volume_x, beautiful.fg_normal)
        widget.popup.icon.image = nice.tint(beautiful.icons.volume_x, beautiful.fg_normal)
    else
        -- widget.arc.opacity = widget.data.volume / 50
        if widget.data.volume > 50 then
            widget.icon.image = nice.tint(beautiful.icons.volume_2, beautiful.fg_normal)
            widget.popup.icon.image = nice.tint(beautiful.icons.volume_2, beautiful.fg_normal)
        elseif widget.data.volume > 0 then
            widget.icon.image = nice.tint(beautiful.icons.volume_1, beautiful.fg_normal)
            widget.popup.icon.image = nice.tint(beautiful.icons.volume_1, beautiful.fg_normal)
        else
            widget.icon.image = nice.tint(beautiful.icons.volume, beautiful.fg_normal)
            widget.popup.icon.image = nice.tint(beautiful.icons.volume, beautiful.fg_normal)
        end
    end
    widget.popup.value.text = tostring(widget.data.volume) .. "%"
end

widget.increase = function(widget)
    widget.data.volume = math.clamp(widget.data.volume + widget.data.STEP, 0, 100)
    nice.a.script("widgets/volume.sh set " .. widget.data.volume)
    widget:update()
    widget.popup:show()
end

widget.decrease = function(widget)
    widget.data.volume = math.clamp(widget.data.volume - widget.data.STEP, 0, 100)
    nice.a.script("widgets/volume.sh set " .. widget.data.volume)
    widget:update()
    widget.popup:show()
end

widget.mute = function(widget)
    widget.data.muted = not widget.data.muted
    nice.a.script("widgets/volume.sh " .. (not widget.data.muted and "unmute" or "mute"))
    widget:update()
    widget.popup:show()
end

globalkey { m = {}, k = "XF86AudioRaiseVolume", g = "media", d = "increase", f = function () widget:increase() end }
globalkey { m = {}, k = "XF86AudioLowerVolume", g = "media", d = "decrease", f = function () widget:decrease() end }
globalkey { m = {}, k = "XF86AudioMute", g = "media", d = "output mute", f = function () widget:mute() end }
-- TODO globalkey { m = {}, k = "XF86AudioMicMute", g = "media", d = "input mute", f = function () end }

nice.widget.button(widget, nice.mouse.left, widget.mute)
nice.widget.button(widget, nice.mouse.up, widget.increase)
nice.widget.button(widget, nice.mouse.down, widget.decrease)

nice.widget.update(widget, 6, function (widget)
    nice.a.script("widgets/volume.sh", function (out)
        local s = string.split(out, " ")
        widget.data.muted = s[1] == "true"
        widget.data.volume = tonumber(s[2])
        widget:update()
    end)
end)

return widget
