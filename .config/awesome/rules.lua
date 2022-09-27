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
      placement = awful.placement.no_overlap+awful.placement.no_offscreen,
      size_hint_honor = true -- required to ensure useless_gap
    }
  },
  {
    rule = { floating = true }, properties = { placement = awful.placement.centered }
  },
  {
    rule_any = { class = { "Steam" } }, properties = { floating = true, fullscreen = true, border_width = 0, shape = nil, screen = awful.screen.primary, size_hints_honor = false }
  },
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
  --[[ steam
  {
    rule = { class = "Steam"} , properties = { tag = "W", screen = 2 }
  },--]]
  nil
}
