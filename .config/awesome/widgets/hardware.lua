local lain = require("lain")

local widget = wibox.widget {
  {
    {
      id = "icon",
      image = beautiful.icon_hardware,
      resize = true,
      widget = wibox.widget.imagebox
    },
    margins = dpi(4),
    layout = wibox.container.margin
  },
  {
    {
      id = "cpu",
      value = 0,
      max_value = 100,
      thickness = dpi(2),
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
  {
    {
      id = "mem",
      value = 0,
      max_value = 100,
      thickness = dpi(2),
      start_angle = math.pi,
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

widget.icon = widget:get_children_by_id("icon")[1]
widget.cpu = widget:get_children_by_id("cpu")[1]
widget.mem = widget:get_children_by_id("mem")[1]

widget.data = {
  cpu = { 0, "..." },
  mem = { 0, 0 }
}

tooltip(widget)

widget.tooltip.update = function ()
  local str = ""
  str = str .. "CPU " .. markup.bold(markup.fg(beautiful.fg_focus, string.format("%.0f", tonumber(widget.data.cpu[1])) .. "%")) .. " (" .. tostring(widget.data.cpu[2]) .. ")\n"
  str = str .. "RAM " .. markup.bold(markup.fg(beautiful.fg_focus, string.format("%.0f", tonumber(widget.data.mem[1])) .. "%")) .. " /" .. tostring(widget.data.mem[2]) .. "\n"
  widget.tooltip.markup = str:sub(1, -2)
end

lain.widget.cpu {
  settings = function ()
    widget.data.cpu = { cpu_now.usage, nil }
    widget.cpu.value = cpu_now.usage / 2
    widget.tooltip.update()
    awful.spawn.easy_async_with_shell("cat /proc/loadavg | cut -c-14", function (stdout)
      widget.data.cpu[2] = string.trim(stdout)
    widget.tooltip.update()
    end)
  end
}

lain.widget.mem {
  settings = function ()
    local _size, _unit = units(mem_now.total * 1024 * 1024)
    widget.data.mem = { mem_now.perc, _size .. _unit }
    widget.mem.value = mem_now.perc / 2
    widget.tooltip.update()
  end
}

widget:buttons(gears.table.join(
  awful.button({}, mouse_left, function () awful.spawn(defaults.hardware) end)
))

--awful.widget.watch("true", 1, function () widget:update() end)

return widget
