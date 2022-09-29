-- xprop

awful.rules.rules = {
  -- all
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen, -- awful.placement.under_mouse
      size_hints_honor = true
    }
  },
  {
    rule = { floating = true }, properties = { placement = awful.placement.centered }
  },
--[[
  {
    rule_any = { class = { "Steam" } }, properties = { floating = false, fullscreen = false, border_width = 0, shape = nil }
  },
--]]
  -- vlc
  {
    rule = { class = "vlc" }, properties = { maximized = true }
  },
  --[[ spotify+cava
  {
    rule = { class = "Spotify" },
    properties = { tag = "W", screen = 1 },
    callback = function (c) awful.spawn(defaults.terminal .. " -e cava") end
  },
  {
    rule = { name = "cava" }, properties = { tag = "W", screen = 2 }
  },--]]
  nil
}
