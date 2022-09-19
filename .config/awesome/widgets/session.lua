-- widget

local widget = wibox.widget.textbox()
widget.text = os.getenv("USER")

-- data

awful.spawn.easy_async_with_shell("echo $(whoami)@$(hostname)", function (stdout)
  widget.text = stdout
end)

-- return

widget:buttons(gears.table.join(
  awful.button({}, mouse_left, function ()
    awful.spawn.with_shell("bash $HOME/.config/rofi/scripts/power")
  end)
))

return widget
