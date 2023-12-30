local awful = require("awful")
local gears = require("gears")

local function _shell(cmdline)
    local handle = io.popen(cmdline)
    local result = handle:read("*a")
    handle:close()
    return string.trim(result)
end

return function (cmdline)
    local args = string.split(cmdline, " ")
    local pid = _shell("pidof " .. tostring(args[1]))
    if not gears.filesystem.dir_readable("/proc/" .. string.trim(pid)) then
        awful.spawn(cmdline)
    end
end
