mouse_left = 1
mouse_middle = 2
mouse_right = 3
mouse_up = 4
mouse_down = 5

-- FIXME root.cursor = "dot"

clientbutton(awful.button({}, mouse_left, function(c)
  c:emit_signal("request::activate", "mouse_click", { raise = true })
end))
--[[
-- FIXME
clientbutton(awful.button({ super }, mouse_left, function(c)
  c:emit_signal("request::activate", "mouse_click", { raise = true })
  awful.mouse.client.move(c)
end))
-- FIXME
clientbutton(awful.button({ super }, mouse_right, function(c)
  c:emit_signal("request::activate", "mouse_click", { raise = true })
  awful.mouse.client.resize(c)
end))
--]]

--[[
-- move mouse to focused client
client.connect_signal("request::activate", function (c, ctx)
  local geo = c:geometry()
  if ctx == "client.focus.byidx" then
    mouse.coords {
      x = geo.x + math.ceil(geo.width /2),
      y = geo.y + math.ceil(geo.height/2)
    }
   end
end)
--]]

--mouse.screen = screen.primary
--geometry = mouse.screen.geometry
--mouse.coords({ x = geometry.x + geometry.width / 2, y = geometry.y + geometry.height / 2 }, true)

--[[ FIXME Super+e
awful.spawn("killall xdotool")
awful.spawn("xdotool behave_screen_edge top-left exec xdotool key --clearmodifiers Super+e")
--]]
