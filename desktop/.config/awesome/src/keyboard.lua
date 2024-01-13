assert(awesome and awful and gears and nice)

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
-- FIXME hangs globalkey(awful.key({ super }, "F1", help.show_help))

globalkey { m = { super }, k = "r", g = "awesome", d = "run", f = function () nice.a.script("run.sh") end }
globalkey { m = { super }, k = "l", g = "awesome", d = "lock", f = function () nice.a.script("session.sh lock") end }
globalkey { m = { super }, k = "Return", g = "awesome", d = "terminal", f = function () nice.a.script("terminal.sh") end }
globalkey { m = { super }, k = "Escape", g = "awesome", d = "exit menu", f = function () nice.a.script("powermenu.sh") end }

-- TODO alt-f4 kill
globalkey { m = { super, control }, k = "r", g = "awesome", d = "restart awesomewm", f = awesome.restart }
globalkey { m = { super, control }, k = "BackSpace", g = "awesome", d = "quit", f = awesome.quit } -- TODO ctrl-alt-suppr

-- globalkey { m = {}, k = "XF86RFKill", g = "network", d = "airplane", f = function ()
    -- nice.shell("nmcli radio all off")
    -- nice.shell("nmcli radio all on")
-- end }

globalkey { m = {}, k = "Print", g = "awesome", d = "screenshot", f = function ()
    nice.a.script("screenshot.sh select", function (out)
        nice.notify.low(beautiful.icons.camera, beautiful.fg_normal, "Screenshot", string.trim(out):gsub("(.*/)(.*)", "%2"))
    end)
end }

local popup = nice.popup(nil, {
    x = -dpi(360 + 8),
    y = dpi(40),
    width = dpi(360),
    height = dpi(8 + 32 + 8),
    {
        nice.widget.icon("brightness_icon", nice.tint(beautiful.icons.sun, beautiful.fg_normal)),
        nice.widget.bar("brightness_bar"),
        {
            id = "brightness_value",
            text = "%",
            widget = wibox.widget.textbox
        },
        layout = wibox.layout.align.horizontal
    },
    margins = beautiful.margin,
    widget = wibox.container.margin
})
popup.icon = popup.widget:get_children_by_id("brightness_icon")[1]
popup.bar = popup.widget:get_children_by_id("brightness_bar")[1]
popup.value = popup.widget:get_children_by_id("brightness_value")[1]
globalkey { m = {}, k = "XF86MonBrightnessUp", g = "screen", d = "brightness +", f = function ()
    nice.a.script("brightness.sh 5%+", function ()
        nice.a.script("brightness.sh", function (out)
            popup.icon.image = nice.tint(beautiful.icons.sunrise, beautiful.fg_normal)
            popup.bar.value = tonumber(out)
            popup.value.text = out .. "%"
            popup:show(1)
        end)
    end)
end }
globalkey { m = {}, k = "XF86MonBrightnessDown", g = "screen", d = "brightness -", f = function ()
    nice.a.script("brightness.sh 5%-", function ()
        nice.a.script("brightness.sh", function (out)
            popup.icon.image = nice.tint(beautiful.icons.sunset, beautiful.fg_normal)
            popup.bar.value = tonumber(out)
            popup.value.text = out .. "%"
            popup:show(1)
        end)
    end)
end }

globalkey { m = { super, control }, k = "r", g = "awesome", d = "restart awesomewm", f = awesome.restart }
globalkey { m = { super, control }, k = "BackSpace", g = "awesome", d = "quit", f = awesome.quit }
