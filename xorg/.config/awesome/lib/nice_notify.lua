assert(awesome and naughty)

local _notifications = {}

local function notify(urgency, icon, title, text)
    title = string.gsub(title or "", '"', "'")
    text = string.gsub(text or "", '"', "'")
    icon = gears.color.recolor_image(icon, "#FFFFFF")
    local id = 0
    for _, notification in pairs(_notifications) do
        if notification.title == title then
            id = notification.id
            break
        end
    end
    local n = _notifications[title:lower()]
    if n then
        n:die(naughty.notificationClosedReason.dismissedByUser)
    end
    if urgency == naughty.config.presets.critical then
        icon = nice.tint(icon or beautiful.icons.warning, beautiful.bg_normal)
    elseif urgency == naughty.config.presets.normal then
        icon = nice.tint(icon or beautiful.icons.info, beautiful.fg_normal)
    else
        icon = icon and nice.tint(icon, beautiful.fg_normal)
    end
    _notifications[title:lower()] = naughty.notify {
        preset = urgency,
        -- screen = 1,
        icon = icon,
        icon_size = dpi(32),
        title = title,
        text = text,
        destroy = function ()
            _notifications[title:lower()] = nil
        end
    }
end

return {
    low = function (icon, title, text) notify(naughty.config.presets.low, icon, title, text) end,
    normal = function (icon, title, text) notify(naughty.config.presets.normal, icon, title, text) end,
    critical = function (icon, title, text) notify(naughty.config.presets.critical, icon, title, text) end
}
