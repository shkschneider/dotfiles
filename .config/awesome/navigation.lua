--local keys = require("keys")

-- alt-tab

local function alttab(i, c)
  local old = awful.client.visible
  awful.client.visible = function (_, s) return old(nil, s) end
  awful.client.focus.byidx(i, c)
  awful.client.visible = old
end

globalkey { m = { super }, k = "Tab", g = "windows", d = "next", f = function() alttab(1) end }
globalkey { m = { super, shift }, k = "Tab", g = "windows", d = "previous", f = function() alttab(-1) end }
--globalkey { m = { super }, k = "o", g = "windows", d = "switch screen", f = awful.client.movetoscreen }
globalkey { m = { super }, k = "o", g = "windows", d = "cycle", f = function ()
  awful.client.cycle(true)
end }

-- switch tags

local function workspace(i)
  local screen = awful.screen.focused()
  local tag = screen.tags[i]
  if tag then
    tag:view_only()
  end
end

local function workspaces(i)
  for screen = 1, screen.count() do
    local tag = awful.tag.gettags(screen)[i]
    if tag then
      awful.tag.viewonly(tag)
    end
  end
end

for i = 1, 9 do
  globalkey { m = { super }, k = "#" .. i + 9, g = "navigation", d = "switch", f = function () workspaces(i) end }
end

-- switch focus

local function focus_by_direction(dir)
  local s = awful.screen.focused()
  if client.focus then
    local id = client.focus.window
    awful.client.focus.bydirection(dir)
    if id == client.focus.window then
      if dir == "up" then
        workspaces(s.selected_tag.index - 1)
      elseif dir == "down" then
        workspaces(s.selected_tag.index + 1)
      end
    end
  else
    if dir == "up" then
      workspaces(s.selected_tag.index - 1)
    elseif dir == "down" then
      workspaces(s.selected_tag.index + 1)
    end
  end
end

globalkey { m = { super }, k = "Up", g = "navigation", d = "focus up", f = function () focus_by_direction("up") end }
globalkey { m = { super }, k = "Down", g = "navigation", d = "focus down", f = function () focus_by_direction("down") end }
--globalkey { m = { super }, k = "Up", g = "navigation", d = "focus up", f = function () workspaces(awful.screen.focused().selected_tag.index - 1) end }
--globalkey { m = { super }, k = "Down", g = "navigation", d = "focus down", f = function () workspaces(awful.screen.focused().selected_tag.index + 1) end }
globalkey { m = { super }, k = "Left", g = "navigation", d = "focus left", f = function () awful.client.focus.global_bydirection("left") end }
globalkey { m = { super }, k = "Right", g = "navigation", d = "focus right", f = function () awful.client.focus.global_bydirection("right") end }

-- move windows

--[[
for i = 1, 9 do
  globalkey { m = { super, control }, k = "#" .. i + 9, g = "navigation", d = "move", f = function()
    if client.focus then
      local tag = client.focus.screen.tags[i]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end
  end }
end
--]]

clientkey { m = { super, control }, k = "Up", g = "navigation", d = "move up", f = function (c)
  if #c.screen.tags == 1 then return end
  local i = c.screen.selected_tag.index
  local t = c.screen.tags[i - 1]
  if t == nil then
    t = c.screen.tags[#c.screen.tags]
  end
  c:move_to_tag(t)
  workspaces(i - 1)
end }
clientkey { m = { super, control }, k = "Down", g = "navigation", d = "move down", f = function (c)
  if #c.screen.tags == 1 then return end
  local i = c.screen.selected_tag.index
  local t = c.screen.tags[i + 1]
  if t == nil then
    t = c.screen.tags[1]
  end
  c:move_to_tag(t)
  workspaces(i + 1)
end }
clientkey { m = { super, control }, k = "Left", g = "navigation", d = "move left", f = function (c)
  c:move_to_screen(c.screen.index - 1)
end }
clientkey { m = { super, control }, k = "Right", g = "navigation", d = "move right", f = function (c)
  c:move_to_screen(c.screen.index + 1)
end }
