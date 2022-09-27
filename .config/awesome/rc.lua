pcall(require, "luarocks.loader")
math.randomseed(os.time())

awful = require("awful")
require("awful.autofocus")
gears = require("gears")
beautiful = require("beautiful")
dpi = beautiful.xresources.apply_dpi
wibox = require("wibox")
--naughty = require("naughty")
markup = require("markup")

require("defaults")
require("theme")("shk")
--require("notifications")
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

awful.spawn.with_shell("run xrandr --output HDMI-0 --primary --mode 1920x1080 --output DP-0 --mode 1440x900 --right-of HDMI-0")
--[[
mouse.screen = 1
mouse.coords {
  x = awful.screen.focused():geometry().width / 2,
  y = awful.screen.focused():geometry().height / 2
}
awful.spawn.with_shell("xdotool click 1")
--]]
awful.spawn.with_shell("bash ~/.config/autostart.sh")

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
