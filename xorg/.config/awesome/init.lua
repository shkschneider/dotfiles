pcall(require, "luarocks.loader")

math.randomseed(os.time())

awful = require "awful"
require "awful.autofocus"
require "awful.rules"

gears = require "gears"

beautiful = require "beautiful"
beautiful.flash_focus_start_opacity = 0.5
beautiful.flash_focus_step = 0.05
dpi = beautiful.xresources.apply_dpi

naughty = require "naughty"

wibox = require "wibox"

awesome.connect_signal("screen::change", awesome.restart)

-- error: startup
if awesome.startup_errors then
    naughty.notify {
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    }
end

-- error: runtime
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        local where, what = err:sub(1, string.find(err, " ") - 2), err:sub(string.find(err, " ") + 1, -1)
        naughty.notify {
            preset = naughty.config.presets.critical,
            title = where,
            text = what
        }
        in_error = false
    end)
end

-- warning: runtime
awesome.connect_signal("debug::deprecation", function (err)
    local where, what = err:sub(1, string.find(err, " ") - 2), err:sub(string.find(err, " ") + 1, -1)
    naughty.notify {
        preset = naughty.config.presets.normal,
        title = where,
        text = what
    }
end)

-- garbage collector
gears.timer {
    timeout = 30,
    autostart = true,
    callback = function ()
        collectgarbage()
    end
}
