-- widget

local widget = wibox.widget.arc(beautiful.icon_loading)
widget.bar.visible = false

widget.update = function ()
  widget.icon.image = beautiful.icon_loading
  awful.spawn.easy_async_with_shell("xbps-install --dry-run --sync --update | cut -d' ' -f1", function (stdout)
    local packages = string.split(stdout, "\n")
    if #packages > 0 then
      widget.icon.image = beautiful.icon_system_ko
    else
      widget.icon.image = beautiful.icon_system_ok
    end
    widget.tooltip.update(packages)
  end)
end

-- tooltip

widget.tooltip = awful.tooltip {
  text = "...",
  fg = beautiful.fg_normal,
  visible = false
}
widget.tooltip.update = function (packages)
  if #packages == 0 then
    widget.tooltip.markup = markup.italic("up-to-date")
    return
  end
  local str = markup.fg(beautiful.fg_urgent, markup.bold(tostring(#packages)) .. " updates") .. "\n"
  for _, p in pairs(packages) do
    local i = string.findlast(p, "-")
    str = str .. markup.fg(beautiful.fg_focus, p:sub(1, i - 1)) .. " " .. p:sub(i + 1, -1) .. "\n"
  end
  widget.tooltip.markup = string.trim(str)
end
tooltip(widget)

-- return

awful.widget.watch("true", 24 * 60 * 60, function ()
  widget:update()
end)

return widget
