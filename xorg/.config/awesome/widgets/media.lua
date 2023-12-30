local function _usec2hms(usec)
  local h, m, s
  m, s = math.modf(usec / 60e6)
  s = math.floor(s * 60)
  h, m = math.modf(m / 60)
  m = math.floor(m * 60)
  return string.format("%02d:%02d:%02d", h, m, s)
end

local function _sec2hms(sec)
  local h, m, s
  m, s = math.modf(sec / 60)
  s = math.floor(s * 60)
  h, m = math.modf(m / 60)
  m = math.floor(m * 60)
  return string.format("%02d:%02d:%02d", h, m, s)
end

local function _parse(out)
    local s = string.split(out, "\n")
    return {
        player = s[1],
        status = (s[2] or ""):lower(),
        artist = tostring(s[3], "?"),
        album = tostring(s[4], "?"),
        title = tostring(s[5], "?"),
        position = tonumber(s[6]),
        duration = tonumber(s[7]),
        cover = s[8] and s[8]:gsub("file://", "")
    }
end

local widget = wibox.widget {
    {
        nice.widget.icon("media_icon", nice.tint(beautiful.icons.headphones, beautiful.fg_normal)),
        top = beautiful.padding, bottom = beautiful.padding,
        layout = wibox.container.margin
    },
    nice.widget.text("media_text", nil, { ellipsize = "end" }),
    layout = wibox.layout.align.horizontal
}
widget.icon = widget:get_children_by_id("media_icon")[1]
widget.text = widget:get_children_by_id("media_text")[1]
-- widget.bar = widget:get_children_by_id("bar")[1] TODO

widget.popup = nice.popup(widget, {
    x = beautiful.margin,
    y = beautiful.margin + dpi(32) + beautiful.margin,
    width = beautiful.margin + dpi(360) + beautiful.margin,
    height = beautiful.margin + dpi(24) * 4 + beautiful.padding * 3 + beautiful.margin,
    {
        id = "cover",
        image = nil,
        forced_width = dpi(96),
        clip_shape = beautiful.shape,
        widget = wibox.widget.imagebox
    },
    {
        {
            nice.widget.text("artist", nil, { align = "right" }),
            nice.widget.text("title", nil, { align = "right" }),
            nice.widget.text("progress", nil, { align = "right" }),
            nice.widget.bar("bar"),
            spacing = beautiful.padding,
            layout = wibox.layout.flex.vertical
        },
        margins = beautiful.margin,
        layout = wibox.container.margin
    },
    layout = wibox.layout.stack
})
widget.popup.cover = widget.popup.widget:get_children_by_id("cover")[1]
widget.popup.artist = widget.popup.widget:get_children_by_id("artist")[1]
widget.popup.title = widget.popup.widget:get_children_by_id("title")[1]
widget.popup.progress = widget.popup.widget:get_children_by_id("progress")[1]
widget.popup.bar = widget.popup.widget:get_children_by_id("bar")[1]
widget.reset = function (self)
    self.text.text = ""
    self.popup.cover.image = nil
    self.popup.artist.text = ""
    self.popup.title.text = ""
    self.popup.bar.value = 0
end

local osd = false
if osd and bling then
    -- https://github.com/BlingCorp/bling/blob/master/signal/playerctl/playerctl_lib.lua
    local playerctl = bling.signal.playerctl.lib {
        ignore = {},
        player = { "vlc", "%any" }
    }
    playerctl:connect_signal("exit", function (_, player_name)
            widget:reset()
    end)
    playerctl:connect_signal("metadata", function(_, title, artist, album_path, album, new, player_name)
        widget.text.markup = markup.bold(artist) .. " " .. markup.italic(title)
        widget.popup.cover.image = album_path
        widget.popup.artist.markup = markup.bold(artist) .. " (" .. (album or "") .. ")"
        widget.popup.title.markup = markup.italic(title)
        widget.popup:show(3)
    end)
    playerctl:connect_signal("position", function(_, interval_sec, length_sec, player_name)
        widget.popup.progress.text = _sec2hms(interval_sec) .. " / " .. _sec2hms(length_sec)
        widget.popup.bar.value = interval_sec
        widget.popup.bar.max_value = length_sec
    end)
    nice.widget.button(widget.popup.widget, nice.mouse.left, function () widget.popup:hide() end)
end

widget.update = function (widget)
    nice.a.script("widgets/media.sh", function (out)
        local t = _parse(out)
        if t.status == "playing" then
            widget.icon.image = nice.tint(beautiful.icons.pause, beautiful.fg_normal)
        elseif t.status == "paused" or t.status == "stopped" then
            widget.icon.image = nice.tint(beautiful.icons.play, beautiful.fg_normal)
        else
            widget.visible = false
            widget:reset()
            return
        end
        widget.visible = true
        if type(t.artist) == "string" and type(t.title) == "string" then
            widget.text.markup = markup.bold(t.artist) .. " - " .. markup.italic(string.ellipsize(t.title, 50))
            widget.text.visible = true
            widget.popup.artist.markup = markup.bold(t.artist) .. " (" .. (t.album or "") .. ")"
            widget.popup.title.markup = markup.italic(t.title)
        end
        if type(t.position) == "number" and type(t.duration) == "number" then
            -- widget.bar.value = t.position TODO
            -- widget.bar.max_value = t.duration TODO
            -- widget.bar.visible = true
            widget.popup.progress.text = _usec2hms(t.position) .. " / " .. _usec2hms(t.duration)
            widget.popup.bar.visible = true
            widget.popup.bar.value = t.position
            widget.popup.bar.max_value = t.duration
        else
            -- widget.bar.visible = false
            widget.popup.bar.visible = false
        end
        widget.popup.cover.image = t.cover or widget.popup.cover.image
    end)
end
nice.widget.update(widget, 1, widget.update)

globalkey { m = {}, k = "XF86AudioPlay", g = "media", d = "play-pause", f = function () nice.a.script("widgets/media.sh play-pause") end }
globalkey { m = {}, k = "XF86AudioPrev", g = "media", d = "previous", f = function () nice.a.script("widgets/media.sh previous") end }
globalkey { m = {}, k = "XF86AudioNext", g = "media", d = "next", f = function () nice.a.script("widgets/media.sh next") end }

nice.widget.button(widget, nice.mouse.left, function () nice.a.script("widgets/media.sh previous") end)
nice.widget.button(widget, nice.mouse.right, function () nice.a.script("widgets/media.sh next") end)

return widget
