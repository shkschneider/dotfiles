local lain = require("lain")

-- widget

local widget = wibox.widget.arc(beautiful.icon_battery_plug)
widget.charge = 100

-- tooltip

widget.tooltip = awful.tooltip {
  text = "...",
  fg = beautiful.fg_normal,
  visible = false
}
widget.tooltip.update = function (status, lvl)
  -- TODO chargin/discharging
  widget.tooltip.markup = markup.fg(beautiful.fg_urgent, status) .. "\n" .. markup.bold(markup.fg(beautiful.fg_focus, lvl) .. "%")
end
tooltip(widget)

-- data

lain.widget.bat {
  settings = function ()
    if not bat_now.status or bat_now.status == "N/A" or bat_now.ac_status == 1 then
      widget.bar.visible = false
      widget.tooltip.update("AC", 100)
    else
      widget.bar.visible = true
      widget.bar.value = bat_now.perc
      widget.tooltip.update(bat_now.status or "?")
      if bat_now.status == "Charging" then
        widget.icon.image = beautiful.icon_battery_up
        widget.bar.colors = { beautiful.fg_normal }
      elseif bat_now.status == "Discharging" then
        widget.icon.image = beautiful.icon_battery_down
        widget.bar.colors = { beautiful.fg_focus }
      end
    end
  end
}

-- return

return widget
