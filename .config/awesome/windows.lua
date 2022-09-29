local lain = require("lain")

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

clientkey { m = { super }, k = "f", g = "windows", d = "fullscreen", f = function (c)
  c.fullscreen = not c.fullscreen
  --c:raise()
end }

clientkey { m = { super }, k = "m", g = "windows", d = "magnify", f = lain.util.magnify_client }

clientkey(awful.key({ super }, "p", function (c)
  if not c.sticky then
    c.sticky = true
    c.border_color = beautiful.border_focus
  else
    c.sticky = false
    c.border_color = beautiful.border_normal
  end
  --c.ontop = not c.ontop
end))
--[[
client.add_signal("property::sticky", function(c)
  c.border_width = 1
  c.border_color = beautiful.border_focus
end)
--]]
--[[
awful.button({}, mouse_left, function(c)
  awful.mouse.client.move(c)
end)
--]]

clientkey { m = { super }, k = "q", g = "windows", d = "kill", f = function (c)
  c:kill()
end }

globalkey { m = { super }, k = "Escape", g = "popup", d = "popup", f = popup }
