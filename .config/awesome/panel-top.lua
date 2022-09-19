-- top = tags

local function callback(w, t, i, _)
  local fg = w:get_children_by_id("text")[1]
  --local bg = w:get_children_by_id("background")[1]
  if t.selected then
    fg.markup = markup.bold(markup.fg(beautiful.fg_focus, markup.underline(t.name)))
    --bg.bg = beautiful.bg_focus
  elseif #t:clients() > 0 then
    fg.markup = markup.fg(beautiful.fg_focus, t.name)
    --bg.bg = nil
  else
    fg.text = t.name
    --bg.bg = nil
  end
end

local template = {
  {
    {
      {
        id = "text",
        widget = wibox.widget.textbox
      },
      layout = wibox.layout.flex.horizontal
    },
    top = dpi(4), bottom = dpi(4),
    left = dpi(8), right = dpi(8),
    widget = wibox.container.margin
  },
  id = "background",
  bg = nil,
  shape = gears.shape.circle,
  widget = wibox.container.background,
  create_callback = callback,
  update_callback = callback
}

local buttons = awful.util.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ super }, 1, function(t) if client.focus then client.focus:move_to_tag(t) end end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ super }, 3, function(t) if client.focus then client.focus:toggle_tag(t) end end),
  awful.button({}, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)

local function tags(s)
  return awful.widget.taglist {
    screen = s,
    filter = function (t)
      return t.index <= #s.tags
    end,
    widget_template = template,
    buttons = buttons
  }
end

local function margin(w)
  return wibox.container.margin(w, dpi(4), dpi(4), dpi(4), nil)
end

local function padding(w)
  return wibox.container.margin(w, dpi(2), dpi(2), nil, nil)
end

local function background(w)
  return wibox.container.background(w, beautiful.bg_normal .. beautiful.alpha, beautiful.shape)
end

return function (widget)
  local s = widget.screen
  widget:setup {
    layout = wibox.layout.align.horizontal,
    expand = "none",
    { -- left
      layout = wibox.layout.fixed.horizontal,
      margin(background(tags(s))),
      margin(background(padding(wibox.widget {
        padding(require("widgets.volume")),
        padding(require("widgets.media")),
        layout = wibox.layout.fixed.horizontal
      })))
    },
    { -- middle
      layout = wibox.layout.align.horizontal,
      margin(background(padding(wibox.widget {
        padding(require("widgets.session")),
        layout = wibox.layout.fixed.horizontal
      })))
    },
    { -- right
      layout = wibox.layout.fixed.horizontal,
      margin(background(padding(wibox.widget {
        padding(require("widgets.hardware")),
        padding(require("widgets.disks")),
        padding(require("widgets.network")),
        layout = wibox.layout.fixed.horizontal
      }))),
      margin(background(
        wibox.widget.systray()
      )),
      margin(background(padding(wibox.widget {
        padding(require("widgets.clock")),
        padding(require("widgets.battery")),
        padding(require("widgets.layouts")),
        padding(require("widgets.system")),
        layout = wibox.layout.fixed.horizontal
      })))
    }
  }
end
