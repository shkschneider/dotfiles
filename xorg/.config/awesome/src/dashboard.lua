assert(awesome and awful and gears and nice)

local u = dpi(16)
local s = dpi(4)

local function margin(widget)
    return {
        widget,
        margins = beautiful.margin,
        layout = wibox.container.margin
    }
end

local function button(widget, onclick)
    local button = wibox.widget {
        forced_width = dpi(48),
        forced_height = dpi(48),
        {
            widget,
            margins = dpi(12),
            layout = wibox.container.margin
        },
        bg = beautiful.bg_normal,
        shape = gears.shape.circle,
        layout = wibox.container.background
    }
    button:connect_signal("mouse::enter", function ()
        button.bg = beautiful.bg_focus
    end)
    button:connect_signal("mouse::leave", function ()
        button.bg = beautiful.bg_normal
    end)
    if onclick then
        button:connect_signal("mouse::press", function ()
            nice.notify.low(nil, "mouse", "press")
        end)
    end
    return button
end

local function block(widget)
    return margin {
        nice.widget.center(widget),
        bg = beautiful.bg_normal,
        opacity = 1,
        shape = beautiful.shape,
        widget = wibox.container.background
    }
end

local board_session_user = wibox.widget { text = "user", widget = wibox.widget.textbox }
local board_session_host = wibox.widget { text = "host", widget = wibox.widget.textbox }
local board_session = block {
    margin {
        image = "/var/lib/AccountsService/icons/" .. os.getenv("USER"),
        forced_width = dpi(48), forced_height = dpi(48),
        widget = wibox.widget.imagebox
    },
    margin {
        board_session_user,
        board_session_host,
        layout = wibox.layout.align.vertical
    },
    layout = wibox.layout.align.horizontal
}
local board_clock = block {
    nice.widget.center(wibox.widget.textclock("%a " .. markup.bold("%d") .. " %b")),
    nice.widget.space(),
    nice.widget.center(wibox.widget.textclock(markup.big(markup.bold("%H") .. " : " .. markup.bold(markup.fg(beautiful.fg_focus, "%M")) .. " : " .. "%S"), 1)),
    layout = wibox.layout.flex.vertical
}
local board_stat_uptime = wibox.widget { widget = wibox.widget.textbox }
local board_stat_filesystem_arc = nice.widget.arc("filesystem_arc", board_stat_uptime, { thickness = dpi(4), colors = { beautiful.fg_focus }, paddings = dpi(8) })
local board_stat_filesystem_value = wibox.widget { text = "%", widget = wibox.widget.textbox, align = "right" }
local board_stat_memory_arc = nice.widget.arc("memory_arc", board_stat_filesystem_arc, { thickness = dpi(4), colors = { beautiful.fg_focus }, paddings = dpi(8) })
local board_stat_memory_value = wibox.widget { text = "%", widget = wibox.widget.textbox, align = "right" }
local board_stat_processor_arc = nice.widget.arc("processor_arc", board_stat_memory_arc, { thickness = dpi(4), colors = { beautiful.fg_focus }, paddings = dpi(8) })
local board_stat_processor_value = wibox.widget { text = "%", widget = wibox.widget.textbox, align = "right" }
local board_stats = block {
    {
        {
            nice.widget.text(nil, "cpu", { align = "left" }),
            nice.widget.text(nil, "ram", { align = "left" }),
            nice.widget.text(nil, "fs", { align = "left" }),
            layout = wibox.layout.flex.vertical
        },
        top = beautiful.margin, bottom = beautiful.margin,
        layout = wibox.container.margin
    },
    {
        margin(board_stat_processor_arc),
        left = dpi(48), right = dpi(48),
        layout = wibox.container.margin
    },
    {
        {
            board_stat_processor_value,
            board_stat_memory_value,
            board_stat_filesystem_value,
            layout = wibox.layout.flex.vertical
        },
        top = beautiful.margin, bottom = beautiful.margin,
        layout = wibox.container.margin
    },
    layout = wibox.layout.align.horizontal
}
local board_media_widget = require("widgets.media").popup.widget
local board_system = block {
    button(nice.widget.icon("system_lock", nice.tint(beautiful.icons.lock, beautiful.fg_normal)), function ()
        nice.notify.low(nil, "session", "lock")
        nice.a.script("session.sh lock")
    end),
    button(nice.widget.icon("system_logout", nice.tint(beautiful.icons.log_out, beautiful.fg_normal)), function ()
        nice.a.script("session.sh logout")
    end),
    button(nice.widget.icon("system_shutdown", nice.tint(beautiful.icons.power, beautiful.fg_normal)), function ()
        nice.a.script("session.sh shutdown")
    end),
    button(nice.widget.icon("system_reboot", nice.tint(beautiful.icons.rotate_ccw, beautiful.fg_normal)), function ()
        nice.a.script("session.sh reboot")
    end),
    spacing = beautiful.padding * 2,
    layout = wibox.layout.flex.horizontal
}
local board_controls = block {
    button(nice.widget.icon("media_previous", nice.tint(beautiful.icons.skip_back, beautiful.fg_normal))),
    button(nice.widget.icon("media_pause", nice.tint(beautiful.icons.pause, beautiful.fg_normal))),
    button(nice.widget.icon("media_next", nice.tint(beautiful.icons.skip_forward, beautiful.fg_normal))),
    spacing = beautiful.padding * 2,
    layout = wibox.layout.flex.horizontal
}
local board = nice.splash({
    width = awful.screen.focused().geometry.width / 2,
    height = board_media_widget.height * 3 + beautiful.margin * 6,
    {
        {
            board_session,
            board_clock,
            layout = wibox.layout.flex.horizontal
        },
        {
            board_stats,
            block {
                board_media_widget,
                layout = wibox.layout.align.horizontal
            },
            layout = wibox.layout.flex.horizontal
        },
        {
            board_system,
            board_controls,
            layout = wibox.layout.flex.horizontal
        },
        -- TODO notification center
        layout = wibox.layout.flex.vertical
    },
    margins = beautiful.margin,
    layout = wibox.container.margin
}, {
    bg = "#00000088"
})

local keygrabber = awful.keygrabber { -- TODO continue
    timeout = 10,
    keybindings = {
        { { super }, "s", function () nice.notify.low(nil, "keygrabber", "super+s") end }
    },
    stop_key = "Escape",
    stop_event = "release",
    start_callback = awful.client.focus.history.disable_tracking,
    stop_callback = awful.client.focus.history.enable_tracking,
    export_keybindings = true
}

nice.a.sync("echo $(whoami)@$(hostname)", function (out)
    local s = string.split(string.trim(out), "@")
    board_session_user.markup = markup.bold(s[1])
    board_session_host.text = s[2]
end)
globalkey { m = { super }, k = "e", g = "awesome", d = "dashboard", f = function ()
    if not board.visible then
        nice.a.script("uptime.sh", function (out)
            board_stat_uptime.markup = markup.bold(string.trim(out))
        end)
        nice.a.script("widgets/hardware.sh", function (out)
            local s = string.split(out, "\n")
            local cpu = string.split(s[1], " ")[1]
            local ram = string.split(s[2], " ")[1]
            board_stat_processor_arc.children[2].value = tonumber(cpu)
            board_stat_processor_value.markup = markup.bold(cpu) .. "%"
            board_stat_memory_arc.children[2].value = tonumber(ram)
            board_stat_memory_value.markup = markup.bold(ram) .. "%"
        end)
        nice.a.script("filesystem.sh", function (out)
            local s = string.split(out, " ")
            local fs = s[4]:match("%d+")
            board_stat_filesystem_arc.children[2].value = tonumber(fs)
            board_stat_filesystem_value.markup = markup.bold(fs) .. "%"
        end)
    end
    board:toggle()
end }
