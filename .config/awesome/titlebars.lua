local titlebars_enabled = true

if titlebars_enabled then
  client.connect_signal("manage", function (c, startup)
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
      --awful.titlebar(c):set_widget(layout)
    end
  end)
  client.connect_signal("request::titlebars", function (c)
    awful.titlebar(c):setup {
      { -- left
        awful.titlebar.widget.iconwidget(c),
        layout = wibox.layout.fixed.horizontal
      },
      nil,
      { -- right
        awful.titlebar.widget.minimizebutton(c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.closebutton(c),
        layout = wibox.layout.fixed.horizontal
      }
    }
  end)
end
