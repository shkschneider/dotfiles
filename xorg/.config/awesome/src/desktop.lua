assert(awesome and awful and beautiful and nice)

local menu = awful.menu {
    items = {
        { "terminal", function () nice.a.script("terminal.sh") end, nil },
        { "file-manager", function () nice.a.script("filemanager.sh") end, nil },
        { "web-browser", function () nice.a.script("webbrowser.sh") end, nil },
        { "power-menu", function () nice.a.script("powermenu.sh") end, nil },
        { "awesome", function ()
            nice.a.script("terminal.sh " .. (os.getenv("EDITOR") or "nano") .. " " .. nice.places.awesome .. "/rc.lua")
        end, nil },
        { "help", function () require("awful.hotkeys_popup").show_help() end, nil }
    }
}
for _, i in ipairs(menu.items) do
    local w = i.widget -- wibox.layout.align
    w = w._private.first -- wibox.layout.fixed
    w = w._private.widgets[1] -- wibox.container.margin
    w._private.left = dpi(8)
    -- w = w._private.widget -- wibox.widget.textbox
end

globalbutton(awful.button({}, nice.mouse.left, function(c) menu:hide() end))
globalbutton(awful.button({}, nice.mouse.middle, function(c) menu:hide() end))
globalbutton(awful.button({}, nice.mouse.right, function(c) menu:show() end))

-- -- TODO laggy so maybe move to something else like ctrl-super-c
-- awful.screen.connect_for_each_screen(function (screen)
    -- awful.wibar {
        -- position = "left",
        -- stretch = false,
        -- ontop = false,
        -- type = "dock",
        -- restrict_workarea = false,
        -- x = beautiful.margin,
        -- y = beautiful.margin + dpi(32) + beautiful.margin,
        -- bg = "#00000000",
        -- fg = "#FFFFFFFF",
        -- width = screen.geometry.width - (beautiful.margin) * 2,
        -- height = screen.geometry.height - (beautiful.margin + dpi(32) + beautiful.margin) * 2
    -- }:setup {
        -- nil, {
            -- date = os.date('*t'),
            -- week_numbers = false,
            -- start_sunday = false,
            -- long_weekdays = false,
            -- widget = wibox.widget.calendar.year
        -- }, nil,
        -- layout = wibox.layout.align.horizontal
    -- }
-- end)
