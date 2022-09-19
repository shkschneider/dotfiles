local paths = {}

local widget = wibox.widget.arc(beautiful.icon_disk)

tooltip(widget)

widget.tooltip.update = function ()
  local str = ""
  for k, v in pairs(paths) do
    str = str .. "/dev/" .. markup.fg(beautiful.fg_focus, k) .. " " .. markup.bold(markup.fg(beautiful.fg_focus, v.used) .. "%") .. " (/" .. v.total .. ")\n"
  end
  widget.tooltip.markup = str:sub(1, -2)
end

local function usage(device)
  awful.spawn.easy_async_with_shell("df --human /dev/" .. device .. " 2>/dev/null | tail -1 | awk '{print $2,$5}' | tr -d '%'", function (stdout)
    local d = {}
    if #stdout > 0 then
      for w in string.gmatch(stdout, "[^ ]+") do table.insert(d, w) end
    end
    paths[device] = { used = tonumber(d[2]), total = d[1] }
    if paths[device].used > 0 then
      widget.bar.value = paths[device].used
    end
    widget.tooltip.update()
  end)
end

local function devices()
  awful.spawn.easy_async_with_shell("cat /proc/diskstats | grep -v loop | awk '{print $3}' | grep '[^0-9]$' | sort", function (stdout)
    local devices = {}
    for device in stdout:gmatch("%w+") do
      table.insert(devices, device)
    end
    table.sort(devices)
    for i=#devices, 1, -1 do
      usage(devices[i])
    end
  end)
end

widget.update = function ()
  devices()
end

awful.widget.watch("true", 60 * 60, function () widget:update() end)

widget:buttons(gears.table.join(
  awful.button({}, mouse_left, function () awful.spawn(defaults.disks) end)
))

return widget
