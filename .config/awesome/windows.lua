local lain = require("lain")

--[[
client.connect_signal("manage", function (c)
  if not awesome.startup then
    awful.client.setslave(c)
  end
  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    awful.placement.no_overlap(c)
    awful.placement.no_offscreen(c)
  end
end)
--]]

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

clientkey { m = { super }, k = "f", g = "windows", d = "fullscreen", f = function (c)
  c.fullscreen = not c.fullscreen
  if c.fullscreen then
    c.shape = nil
  else
    c.shape = beautiful.shape
  end
  c:raise()
end }

--[[
local lock = false
clientkey { m = { super }, k = "g", g = "windows", d = "gaming mode", f = function (c)
  lock = not lock
  c:connect_signal("mouse::leave", function (c)
    if lock then
      local cg = c:geometry()
      local mc = mouse.coords()
      local x = mc.x <= cg.x and cg.x + 5 or mc.x >= (cg.x + cg.width) and cg.x + cg.width - 5 or mc.x
      local y = mc.y <= cg.y and cg.y + 5 or mc.y >= (cg.y + cg.height) and cg.y + cg.height - 5 or mc.y
      mouse.coords { x = x, y = x }
    end
  end)
end }
--]]

clientkey { m = { super }, k = "m", g = "windows", d = "magnify", f = lain.util.magnify_client }

--[[
clientkey(awful.key({ super }, "m", function (c) end))
clientkey(awful.key({ super }, "n", function (c) c.minimized = true end))
--]]

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
--client.add_signal("property::sticky", function(c) c.border_color = beautiful.border_focus end)

--[[
clientkey(awful.key({ super }, "c", function (c)
  awful.placement.centered(c, { honor_workarea = true, honor_padding = true })
end))
--]]

clientkey { m = { super }, k = "q", g = "windows", d = "kill", f = function (c)
  c:kill()
end }

-- items

--[[
local clients = client.get()
for _, c in ipairs(clients) do
  c.minimized = true
end
...
for _, c in ipairs(clients) do
  c.minimized = false
end
--]]

globalkey { m = { super }, k = "Escape", g = "popup", d = "popup", f = popup }
