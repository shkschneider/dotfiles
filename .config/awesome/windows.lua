local lain = require("lain")

-- borders

screen.connect_signal("arrange", function (s)
  local single = #s.tiled_clients == 1
  for _, c in pairs(s.clients) do
    if single and not c.floating or c.maximized or c.fullscreen then
      c.border_width = 0
    else
      c.border_width = beautiful.border_width
    end
  end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- fullscreen

clientkey { m = { super }, k = "f", g = "windows", d = "fullscreen", f = function (c)
  c.fullscreen = not c.fullscreen
  c:raise()
end }

--clientkey { m = { super }, k = "m", g = "windows", d = "magnify", f = lain.util.magnify_client }

--[[ sticky
clientkey(awful.key({ super }, "p", function (c)
  if not c.sticky then
    c.sticky = true
  else
    c.sticky = false
  end
  --c.ontop = not c.ontop
end))
client.add_signal("property::sticky", function(c)
  if c.sticky then
    c.border_color = beautiful.border_focus
  else
    c.border_color = beautiful.border_normal
  end
end)
--]]

-- open/close

clientkey { m = { super }, k = "q", g = "windows", d = "kill", f = function (c)
  c:kill()
end }
