local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local widget = wibox.widget {
  orientation = "vertical",
  color = "#00000000",
  forced_width = dpi(4),
  widget = wibox.widget.separator
}

--[[
local widget = wibox.widget.textbox()

widget:set_text(" ")
--]]

return widget
