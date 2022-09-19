local awful = require("awful")
local gears = require("gears")

local tags = { "A", "W", "E", "S", "O", "M", "E" }
awful.tag(tags, s, awful.layout.layouts[1])

local widget = awful.widget.taglist {
    screen = s,
    filter = function (t)
      return t.index <= #tags
    end,
    style = {
      shape = gears.shape.rounded_rect
    },
    -- TODO widget_template = {},
    buttons = gears.table.join(
      awful.button({}, 1, function(t) t:view_only() end),
      awful.button({ super }, 1, function(t) if client.focus then client.focus:move_to_tag(t) end end),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({ super }, 3, function(t) if client.focus then client.focus:toggle_tag(t) end end),
      awful.button({}, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
      awful.button({}, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
    )
  }

return widget
