assert(awesome and awful)

-- focus

for index = 1, 9 do
    globalkey { m = { super }, k = "#" .. index + 9, g = "navigation", d = "switch", f = function ()
        nice.navigation.focus_tag_indexed(index)
    end }
end

globalkey { m = { super }, k = "Tab", g = "windows", d = "next", f = function(c)
    nice.navigation.focus_next_client()
end }
globalkey { m = { super, shift }, k = "Tab", g = "windows", d = "previous", f = function(c)
    nice.navigation.focus_previous_client()
end }
-- globalkey { m = { super }, k = "u", g = "windows", d = "urgent", f = function(c)
    -- awful.client.urgent.jumpto(c)
-- end }

globalkey { m = { super }, k = "Up", g = "navigation", d = "focus up", f = function ()
    nice.navigation.focus_relative("up")
end }
globalkey { m = { super }, k = "Down", g = "navigation", d = "focus down", f = function ()
    nice.navigation.focus_relative("down")
end }
globalkey { m = { super }, k = "Left", g = "navigation", d = "focus left", f = function ()
    nice.navigation.focus_relative("left")
end }
globalkey { m = { super }, k = "Right", g = "navigation", d = "focus right", f = function ()
    nice.navigation.focus_relative("right")
end }

-- move

for index = 1, 9 do
    globalkey { m = { super, control }, k = "#" .. index + 9, g = "navigation", d = "move", f = function()
        nice.navigation.move_to_tag_indexed(index)
    end }
end

clientkey { m = { super, control }, k = "Up", g = "navigation", d = "move up", f = function (c)
    nice.navigation.move_relative("up", c)
end }
clientkey { m = { super, control }, k = "Down", g = "navigation", d = "move down", f = function (c)
    nice.navigation.move_relative("down", c)
end }
clientkey { m = { super, control }, k = "Left", g = "navigation", d = "move left", f = function (c)
    nice.navigation.move_relative("left", c)
end }
clientkey { m = { super, control }, k = "Right", g = "navigation", d = "move right", f = function (c)
    nice.navigation.move_relative("right", c)
end }
