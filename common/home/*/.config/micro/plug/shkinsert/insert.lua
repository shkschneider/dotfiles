NAME = "shk-insert"
VERSION = "1.0.0"

local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local shell = import("micro/shell")
local strings = import("strings")

function Insert(bp, args)
    micro.InfoBar():Prompt("Insert: ", "", "Insert", nil, function (out, cancelled)
        if cancelled then return end
        out = strings.TrimSpace(out)
        micro.InfoBar():GutterMessage(out)
        local out, err = shell.RunCommand(out)
        if err then return micro.InfoBar():Error(tostring(err)) end
        bp.Buf:Insert(buffer.Loc(bp.Cursor.Loc.X, bp.Cursor.Loc.Y), out)
    end)
end

function init()
    config.MakeCommand("insert", Insert, config.NoComplete)
end
