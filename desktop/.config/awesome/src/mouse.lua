assert(awesome and awful and beautiful and nice)

local sloppy = true
if sloppy then
    client.connect_signal("mouse::enter", function(c)
        c:emit_signal("request::activate", "mouse_enter", { raise = false })
    end)
else
    clientbutton(awful.button({}, nice.mouse.left, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end))
end
