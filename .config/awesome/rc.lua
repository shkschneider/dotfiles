pcall(require, "luarocks.loader")
math.randomseed(os.time())

awful = require("awful")
require("awful.autofocus")
gears = require("gears")
beautiful = require("beautiful")
dpi = beautiful.xresources.apply_dpi
wibox = require("wibox")
markup = require("markup")

require("defaults")
require("theme")("shk")
require("notifications")
require("keys")
require("layouts")
require("mouse")
require("panels")
require("windows")
require("navigation")

-- WIP require("titlebars")

require("help")

root.keys(globalkeys or {})
root.buttons(globalbuttons or {})
require("rules")

awful.spawn.with_shell("bash ~/.config/autostart.sh")

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
