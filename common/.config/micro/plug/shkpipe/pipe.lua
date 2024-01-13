NAME = "shk-pipe"
VERSION = "1.1.0"

local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local util = import("micro/util")
local strings = import("strings")

function Pipe(bp, args)
    if not bp.Cursor:HasSelection() then return micro.InfoBar():Error("No selection") end
    local selection = util.String(bp.Cursor:GetSelection())
    micro.InfoBar():Prompt("Pipe: ", "", "Pipe", nil, function (out, cancelled)
        if cancelled then return end
        command = strings.TrimSpace(out)
        bp:HandleCommand("textfilter " .. out)
        micro.InfoBar():Message(out)
    end)
end

function init()
    config.MakeCommand("pipe", Pipe, config.NoComplete)
    config.TryBindKey("Ctrl-p", "command:pipe", false)
end
