require("help")

super = "Mod4"
alt = "Mod1"
shift = "Shift"
control = "Control"

function globalkey(key)
  globalkeys = gears.table.join(globalkeys or {}, helpkey(key))
end

function globalbutton(button)
  globalbuttons = gears.table.join(globalbuttons or {}, button)
end

function clientkey(key)
  clientkeys = gears.table.join(clientkeys or {}, helpkey(key))
end

function clientbutton(button)
  clientbuttons = gears.table.join(clientbuttons or {}, button)
end

globalkey(awful.key({ super }, "F1", help.show_help))

globalkey { m = { super, control }, k = "r", g = "awesome", d = "restart awesomewm", f = awesome.restart }
globalkey { m = { super }, k = "l", g = "awesome", d = "lock", f = function ()
  awful.spawn("sync")
  awful.spawn(defaults.lock)
end }
globalkey { m = {}, k = "Print", g = "awesome", d = "screenshot", f = function () notify("Print", "TODO") end } -- TODO
globalkey { m = { super }, k = "r", g = "awesome", d = "run", f = function () awful.spawn.with_shell(defaults.run) end }
globalkey { m = { super }, k = "Return", g = "awesome", d = "terminal", f = function () awful.spawn(defaults.terminal) end }
globalkey { m = { super, control }, k = "BackSpace", g = "awesome", d = "quit", f = awesome.quit }
globalkey { m = { super }, k = "Escape", g = "awesome", d = "exit menu", f = function ()
  awful.spawn.with_shell(defaults.power)
end }

--[[
globalkey { m = {}, k = "XF86MonBrightnessUp", g = "screen", d = "brightness +", f = function ()
  -- xbacklight -inc 10
  -- brightnessctl set 5%+ -q
end }
globalkey { m = {}, k = XF86MonBrightnessDown", g = "screen", d = "brightness -", f = function ()
  -- xbacklight -dec 10
  -- brightnessctl set 5%- -q
end }
--]]
