mouse_left = 1
mouse_middle = 2
mouse_right = 3
mouse_up = 4
mouse_down = 5

clientbutton(awful.button({}, mouse_left, function(c)
  c:emit_signal("request::activate", "mouse_click", { raise = true })
end))
