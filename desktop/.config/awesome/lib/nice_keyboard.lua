assert(awesome and gears)

super = "Mod4"
alt = "Mod1"
shift = "Shift"
control = "Control"
altgr = "Mod5"

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
local help = require("awful.hotkeys_popup")
function helpkey(key)
  if key.m and key.k and key.g and key.d and key.d then
    local keys = {}
    keys[key.k] = key.d
    help.widget.add_hotkeys { [key.g] = { { modifiers = key.m, keys = keys } } }
    return awful.key(key.m, key.k, key.f)
  else
    return key
  end
end
globalkey { m = { super }, k = "F1", g = "awesome", d = "help", f = help.show_help }
globalkey { m = { super, control }, k = "r", g = "awesome", d = "restart awesomewm", f = awesome.restart }
globalkey { m = { super, control }, k = "BackSpace", g = "awesome", d = "quit", f = awesome.quit }

return {
    super = super,
    alt = alt,
    shift = shift,
    control = control,
    altgr = altgr
}
