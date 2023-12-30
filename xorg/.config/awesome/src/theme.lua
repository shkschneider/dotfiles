assert(awesome and awful and beautiful)

-- wallpaper

screen.connect_signal("property::geometry", nice.wallpaper)
awful.screen.connect_for_each_screen(nice.wallpaper)

-- icons

local function files(dir, f)
    local files = require("lgi").Gio.File.new_for_path(dir):enumerate_children("standard::*", 0)
    if files then
        for file in function() return files:next_file() end do
            if type(f) == "function" then
                f(file:get_display_name(), dir .. "/" .. file:get_display_name())
            end
        end
    end
end

return function (name)
    nice.theme(name)
    assert(beautiful.fg_normal and beautiful.fg_focus and beautiful.fg_urgent)
    assert(beautiful.bg_normal and beautiful.bg_focus and beautiful.bg_urgent)
    assert(beautiful.margin and beautiful.padding)
    assert(beautiful.font)
    assert(beautiful.shape)
    beautiful.icons = {}
    files(nice.places.icons, function (file, path)
        if gears.filesystem.file_readable(path) then
            local basename = file:match("(.+)%..+$"):gsub("-", "_")
            beautiful.icons[basename] = path
        end
    end)
    files(nice.places.themes .. "default/layouts", function (file, path)
        local basename = file:match("(.+)%..+$"):sub(1, -2)
        beautiful["layout_" .. basename] = path
    end)
end
