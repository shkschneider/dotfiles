local widget = wibox.widget.textbox()
nice.widget.tooltip(widget)

widget.text = os.getenv("USER")
nice.a.sync("echo $(whoami)@$(hostname)", function (out)
    widget.text = string.trim(out)
end)

nice.a.script("widgets/session.sh", function (out)
    widget.tooltip.text = string.trim(out)
end)

nice.widget.button(widget, nice.mouse.left, function () nice.a.script("powermenu.sh") end)

return widget
