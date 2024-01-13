local widget = wibox.widget {
    nice.widget.icon("applications", nice.tint(beautiful.icons.grid, beautiful.fg_normal)),
    layout = wibox.container.place
}

-- local menu = awful.menu { items = {} }
-- nice.a.script("widgets/applications.sh", function (out)
    -- local s = string.split(out, "\n")
    -- for _, ss in ipairs(s) do
        -- table.insert(menu.items, string.split(ss, ";"))
    -- end
-- end)

-- myawesomemenu = {
    -- { "test", function () end}
-- }
-- mymainmenu = awful.menu{ items = {
    -- { "awesome", myawesomemenu, nil},
    -- { "terminal", "?" }
-- }}
-- mylauncher = awful.widget.launcher { image = nil, menu = mymainmenu }

nice.widget.button(widget, nice.mouse.left, function ()
    -- mymainmenu:show()
    local items = {}
    nice.a.script("widgets/applications.sh", function (out)
        local s = string.split(out, "\n")
        for _, ss in ipairs(s) do
            local item = string.split(ss, ";")
            table.insert(items, {
                item[2],
                function ()
                    nice.notify.low(nil, "app", item[2])
                end,
                nil
            })
        end
        awful.menu { items = items, parent = widget }:show()
    end)
end)

return widget
