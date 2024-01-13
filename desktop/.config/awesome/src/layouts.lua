assert(awesome and awful)
local bling = require "bling"

awful.layout.layouts = {
    bling.layout.centered,
    awful.layout.suit.floating,
    --awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    --bling.layout.vertical,
    --bling.layout.horizontal,
    bling.layout.equalarea
}

awful.screen.connect_for_each_screen(function (screen)
    awful.tag({ "A", "W", "E", "S", "O", "M", "E" }, s, awful.layout.layouts[1])
end)
