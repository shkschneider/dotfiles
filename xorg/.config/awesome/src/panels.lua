assert(awesome and awful and wibox)

local function primary(s, w) return s.index == 1 and w end

-- because I wrap the systray I'll also wrap the adjacent widgets
local function rounded(widget)
    return wibox.widget {
        {
            widget,
            margins = beautiful.margin,
            layout = wibox.container.margin
        },
        bg = beautiful.bg_normal,
        shape = beautiful.shape or gears.shape.rounded_rect,
        shape_clip = true,
        widget = wibox.container.background
    }
end

-- systray seems to not follow beautiful.bg_systray so I wrap it and hide it when I can
local function systray()
    local widget = wibox.widget.systray()
    -- :setup { TODO?
        -- nice.widget.text(nil, "text"),
        -- layout = wibox.layout.flex.horizontal
    -- }
    local container = rounded(widget)
    gears.timer {
        timeout = 60,
        call_now = true,
        autostart = true,
        callback = function ()
            container.visible = type(awesome.systray()) == "number" and awesome.systray() > 0
        end
    }
    return container
end

local function block(widget)
    assert(widget.widget or widget.layout)
    return wibox.container.background(
        wibox.container.margin(
            widget,
        beautiful.padding, beautiful.padding, beautiful.padding, beautiful.padding),
    beautiful.bg_normal, beautiful.shape)
end

awful.screen.connect_for_each_screen(function (screen)
    -- top
    awful.wibar {
        position = "top",
        stretch = true,
        border_width = 0,
        ontop = false,
        type = "dock",
        width = screen.geometry.width,
        height = beautiful.margin + dpi(24) + beautiful.margin, -- actually like margin+32+margin -_-
        screen = screen,
        bg = beautiful.bg_normal .. "00",
        fg = beautiful.fg_normal .. "FF"
    }:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- left
            {
                block(wibox.widget {
                    require("widgets.tags")(screen),
                    layout = wibox.layout.align.horizontal
                }),
                nice.widget.space(beautiful.padding),
                block(wibox.widget {
                    require("widgets.volume"),
                    nice.widget.space(beautiful.padding),
                    require("widgets.media"),
                    layout = wibox.layout.align.horizontal
                }),
                layout = wibox.layout.align.horizontal
            },
            left = beautiful.margin, top = beautiful.margin,
            layout = wibox.container.margin
        },
        nil, -- middle
        { -- right
            {
                block(wibox.widget {
                    require("widgets.hardware"),
                    nice.widget.space(beautiful.padding),
                    require("widgets.storage"),
                    nice.widget.space(beautiful.padding),
                    require("widgets.network"),
                    nice.widget.space(beautiful.padding),
                    require("widgets.network2"),
                    layout = wibox.layout.fixed.horizontal
                }),
                nice.widget.space(beautiful.padding),
                block(wibox.widget {
                    require("widgets.battery"),
                    nice.widget.space(beautiful.padding),
                    require("widgets.layouts"),
                    nice.widget.space(beautiful.padding),
                    require("widgets.system"),
                    layout = wibox.layout.fixed.horizontal
                }),
                layout = wibox.layout.fixed.horizontal
            },
            right = beautiful.margin, top = beautiful.margin,
            layout = wibox.container.margin
        }
    }
    -- bottom
    awful.wibar {
        position = "bottom",
        stretch = false,
        border_width = 0,
        ontop = false,
        type = "dock",
        width = screen.geometry.width,
        height = beautiful.margin + dpi(24) + beautiful.margin,
        screen = screen,
        bg = beautiful.bg_normal .. "00",
        fg = beautiful.fg_normal .. "FF"
    }:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- left
            {
                block(wibox.widget {
                    require("widgets.applications"),
                    layout = wibox.layout.fixed.horizontal
                }),
                nice.widget.space(beautiful.padding),
                require("widgets.tasks")(screen),
                nice.widget.space(beautiful.padding),
                layout = wibox.layout.fixed.horizontal
            },
            left = beautiful.margin, bottom = beautiful.margin,
            layout = wibox.container.margin
        },
        { -- middle
            awful.widget.prompt { prompt = "/> " },
            layout = wibox.layout.fixed.horizontal
        },
        { -- right
            {
                primary(screen, wibox.container.margin(systray(), beautiful.padding, beautiful.padding, nil, nil)),
                primary(screen, wibox.container.margin(rounded(awful.widget.keyboardlayout()), beautiful.padding, beautiful.padding, nil, nil)),
                block(wibox.widget {
                    require("widgets.clock"),
                    layout = wibox.layout.fixed.horizontal
                }),
                layout = wibox.layout.fixed.horizontal
            },
            right = beautiful.margin, bottom = beautiful.margin,
            layout = wibox.container.margin
        }
    }
end)
