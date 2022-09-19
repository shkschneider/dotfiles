string.trim = function (s)
  return s:gsub("^%s+", ""):gsub("%s+$", "")
end

string.split = function (s, c)
  local t = {}
  string.gsub(s, string.format("([^%s]+)", c or " "), function (p)
    table.insert(t, p)
  end)
  return t
end

string.findlast = function(str, s)
  local i = str:match(".*" .. s .. "()")
  if not i then return nil else return i -1 end
end

local _units = {
  [1] = "K",
  [2] = "M",
  [3] = "G",
  [4] = "T",
  [5] = "P",
  [6] = "E",
  [7] = "Z",
  [8] = "Y"
}

function units(n)
  local u = math.floor(math.log(n) / math.log(1024))
  return math.floor(n / math.pow(1024, u)), _units[u]
end

function tooltip(o)
  if o.tooltip == nil then
    o.tooltip = awful.tooltip {
      text = nil,
      fg = beautiful.fg_normal,
      visible = false
    }
  end
  local t = o.tooltip
  t:add_to_object(o)
  o:connect_signal("mouse::enter", function ()
    t.visible = true
  end)
  o:connect_signal("mouse::leave", function ()
    t.visible = false
  end)
end

wibox.widget.arc = function (icon)
  local widget = wibox.widget {
    {
      {
        id = "icon",
        image = icon or nil,
        resize = true,
        widget = wibox.widget.imagebox
      },
      margins = dpi(4),
      layout = wibox.container.margin
    },
    {
      {
        id = "bar",
        value = 0,
        max_value = 100,
        thickness = dpi(1),
        start_angle = 0, --math.pi
        rounded_edge = true,
        paddings = 0,
        bg = nil,
        colors = { beautiful.fg_focus },
        widget = wibox.container.arcchart
      },
      margins = dpi(2),
      layout = wibox.container.margin
    },
    layout = wibox.layout.stack,
  }
  widget.bar = widget:get_children_by_id("bar")[1]
  widget.icon = widget:get_children_by_id("icon")[1]
  return widget
end
