assert(awesome and awful and gears and beautiful and naughty and wibox)
markup = require "lib.markup"
require "lib.math"
require "lib.string"

return {
    a = {
        sync = function (cmdline, f)
            awful.spawn.easy_async_with_shell(cmdline, f or (function () end))
        end,
        script = function (cmdline, f)
            local args = string.split(cmdline, " ")
            local dirs = {
                nice.places.awesome, nice.places.scripts, nice.places.home .. ".local/bin/"
            }
            for _, dir in ipairs(dirs) do
                if gears.filesystem.file_executable(dir .. args[1]) then
                    awful.spawn.easy_async_with_shell(dir .. cmdline, f or (function () end))
                    return
                elseif gears.filesystem.file_readable(dir .. args[1]) then
                    awful.spawn.easy_async_with_shell("sh " .. dir .. cmdline, f or (function () end))
                    return
                end
            end
            nice.notify.critical(nice.tint(beautiful.icons.error, beautiful.bg_normal), "nice.a.script(" .. tostring(args[1]) .. ")", tostring(cmdline))
        end
    },
    run = {
        now = awful.spawn,
        once = require "lib.run_once"
    },
    wallpaper = function (screen, path)
        local wallpaper = path or beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(screen)
        end
        -- TODO all screens
        gears.wallpaper.maximized(wallpaper, screen, true)
    end,
    theme = function (name)
        name = name and (gears.filesystem.get_configuration_dir() .. name .. ".lua")
        if not gears.filesystem.file_readable(name) then
            name = nice.places.themes .. "default/theme.lua"
        end
        beautiful.init(name)
    end,
    dpi = beautiful.xresources.apply_dpi,
    tint = gears.color.recolor_image,
    mouse = {
        left = 1, middle = 2, right = 3, up = 4, down = 5
    },
    notify = require "lib.nice_notify",
    places = {
        home = os.getenv("HOME"),
        config = gears.filesystem.get_xdg_config_home(),
        awesome = gears.filesystem.get_configuration_dir(),
        scripts = gears.filesystem.get_xdg_config_home() .. "wm/scripts/",
        icons = gears.filesystem.get_xdg_config_home() .. "wm/icons/",
        themes = gears.filesystem.get_themes_dir(),
        wallpapers = gears.filesystem.get_xdg_config_home() .. "wm/wallpapers/",
        cache = gears.filesystem.get_cache_dir()
    },
    pretty = {
        time = require "lib.pretty_time",
        size = require "lib.pretty_size"
    },
    widget = require "lib.nice_widget",
    popup = require "lib.nice_popup",
    keyboard = require "lib.nice_keyboard",
    splash = require "lib.nice_splash",
    effects = require "lib.nice_effects",
    navigation = require "lib.nice_navigation"
}
