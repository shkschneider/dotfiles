beautiful.tasklist_plain_task_name=true

return function (s)
    return awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        -- style = {
            -- shape = function (cr, w, h) return gears.shape.partially_rounded_rect(cr, w, h, false, true, true, false, 6) end
        -- },
        widget_template = {
            {
                -- icon_role wibox.widget.imagebox
                {
                    id = "task_clienticon",
                    widget = awful.widget.clienticon,
                },
                -- text_role wibox.widget.textbox
                -- background_role wibox.widget.background
                layout = wibox.layout.fixed.horizontal,
            },
            margins = beautiful.padding,
            widget = wibox.container.margin,
            create_callback = function (self, c, index, objects)
                self:get_children_by_id("task_clienticon")[1].client = c
                awful.tooltip {
                    objects = { self },
                    timer_function = function() return c.name end
                }
            end
        },
        buttons = awful.util.table.join(
            awful.button({}, 1, function (c)
                c:emit_signal("request::activate", "mouse_click", { raise = true })
            end)
        ),
        layout = {
            spacing = 10,
            spacing_widget = {
                {
                    forced_width = 2.5,
                    shape = gears.shape.circle,
                    widget = wibox.widget.separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place
            },
            layout  = wibox.layout.flex.horizontal
        }
    }
end
