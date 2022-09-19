local lain = require("lain")

-- bottom = tasks

local function margin(w)
  return wibox.container.margin(w, dpi(4), dpi(4), nil, dpi(4))
end

local function padding(w)
  return wibox.container.margin(w, dpi(2), dpi(2), nil, nil)
end

local function background(w)
  return wibox.container.background(w, beautiful.bg_normal .. beautiful.alpha, beautiful.shape)
end

local function tasks(s)
  return awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    style = {
      --shape = function (cr, w, h) return gears.shape.partially_rounded_rect(cr, w, h, false, true, true, false, 6) end
    },
    --widget_template = nil,
    --buttons = nil,
    layout = {
      spacing = 10,
      spacing_widget = {
        {
          forced_width = 5,
          shape = gears.shape.circle,
          widget = wibox.widget.separator
        },
        valign = "center",
        halign = "center",
        widget = wibox.container.place
      },
      layout  = wibox.layout.flex.horizontal
    }
  }
end

return function (widget)
  local s = widget.screen
  widget:setup {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    nil,
    {
      layout = wibox.layout.fixed.horizontal,
      margin(background(padding(wibox.widget {
        tasks(s),
        layout = wibox.layout.fixed.horizontal
      })))
    },
    nil
  }
end
