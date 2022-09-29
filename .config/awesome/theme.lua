-- luarocks install lgi
local lgi = require("lgi")

local function files(dir, f)
  local files = lgi.Gio.File.new_for_path(dir):enumerate_children("standard::*", 0)
  if files then
    for file in function() return files:next_file() end do
      if type(f) == "function" then
        f(file:get_display_name(), dir .. "/" .. file:get_display_name())
      end
    end
  end
end

function set_wallpaper(s)
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end
screen.connect_signal("property::geometry", set_wallpaper)

return function (t)
  -- theming
  beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
  --beautiful.init("~/.awesome/themes/monokai/theme.lua")
  require("themes.shk")
  -- wallpaper
  awful.screen.connect_for_each_screen(function (s)
    set_wallpaper(s)
  end)
  -- source all icons
  files(gears.filesystem.get_themes_dir() .. "default/layouts", function (file, path)
    local basename = file:match("(.+)%..+$"):sub(1, -2)
    beautiful["layout_" .. basename] = path
  end)
  files(gears.filesystem.get_configuration_dir() .. "icons", function (file, path)
    local basename = file:match("(.+)%..+$")
    beautiful["icon_" .. basename] = path
  end)
end
