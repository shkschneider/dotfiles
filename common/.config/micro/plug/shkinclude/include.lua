NAME = "shk-include"
VERSION = "1.1.0"

local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local strings = import("strings")
local ioutil = import("io/ioutil")
local filepath = import("path/filepath")
local os = import("os")

function Include(bp, args)
    local path = filepath.Join(os.Getwd() or "", "$"):sub(1, -2)
    micro.InfoBar():Prompt("Include: ", path, "Include", nil, function (out, cancelled)
        if cancelled then return end
        out = strings.TrimSpace(out)
        micro.InfoBar():GutterMessage(out)
        local out, err = ioutil.ReadFile(out)
        if err then return micro.InfoBar():Error(tostring(err)) end
        bp.Buf:Insert(buffer.Loc(bp.Cursor.Loc.X, bp.Cursor.Loc.Y), out)
    end)
end

function init()
    config.MakeCommand("include", Include, buffer.FileComplete)
end
