VERSION = "1.1.0"

local micro = import("micro")
local config = import("micro/config")
local shell = import("micro/shell")
local buffer = import("micro/buffer")

local function _include(bp, out, err)
    --out = strings.TrimSpace(out)
    if err then
        err = (out and #out > 0) and out or err
        return
    end
    bp.Buf:Insert(buffer.Loc(bp.Cursor.Loc.X, bp.Cursor.Loc.Y), out)
end

function include_file(bp, args)
    local filepath = import("path/filepath")
    local strings = import("strings")
    local os = import("os")
    local path = filepath.Join(os.Getwd() or "", "$"):sub(1, -2)
    micro.InfoBar():Prompt("include-file: ", path, "", nil, function(out, cancelled)
        if cancelled then return end
        out = strings.TrimSpace(out)
        local loc = bp.Cursor.Loc
        local out, err = shell.RunCommand("cat '" .. out .. "'")
        _include(bp, out, err)
    end)
end

function include_shell(bp, args)
    local filepath = import("path/filepath")
    local strings = import("strings")
    local os = import("os")
    local path = filepath.Join(os.Getwd() or "", "$"):sub(1, -2)
    micro.InfoBar():Prompt(path .. "$ ", "", "", nil, function(out, cancelled)
        if cancelled then return end
        out = strings.TrimSpace(out)
        local loc = bp.Cursor.Loc
        local out, err = shell.RunCommand(out)
        _include(bp, out, err)
    end)
end

function init()
    config.MakeCommand("include-file", include_file, config.NoComplete)
    config.MakeCommand("include-shell", include_shell, config.NoComplete)
    --config.TryBindKey("Alt-i", "command:include-file", false)
end
