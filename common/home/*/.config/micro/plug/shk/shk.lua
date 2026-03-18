NAME = "shk"
VERSION = "2.0.0"

local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")

function Help(bp, args)
    local buf = buffer.NewBuffer("", "")
    micro.CurPane():HSplitIndex(buf, true)
    local lines = {
        "include ['file']",
        "insert ['sh-command']",
        "jump <top|above|below|bottom>",
        "explore",
        "case [...]",
        "pipe [...]",
    }
    for i, line in ipairs(lines) do
        buf:Insert(buffer.Loc(bp.Cursor.Loc.X, bp.Cursor.Loc.Y), line)
        buf:Insert(buffer.Loc(bp.Cursor.Loc.X, bp.Cursor.Loc.Y), "\n")
    end
end

-- local micro = import("micro")
-- local config = import("micro/config")
-- local buffer = import("micro/buffer")
-- local shell = import("micro/shell")
-- local util = import("micro/util")
-- local strings = import("strings")
-- local ioutil = import("io/ioutil")
-- local filepath = import("path/filepath")
-- local os = import("os")
-- local math = import("math")

-- list tabs and switch
-- list recent files
function SwitchTab(bp, args)
    micro.Log(micro.CurTab())
    micro.Log(micro.CurTab():CurPane())
    micro.Log(micro.CurTab():CurPane():Name())
    micro.InfoBar():Message(micro.Tabs)
    -- get all tabs
    -- bp.Buf.AbsPath
    -- fzf
    -- switch
end

function init()
    micro.SetStatusInfoFn("shk.StatusLeft")
    micro.SetStatusInfoFn("shk.StatusRight")
    --config.MakeCommand("shk.Help", Help, config.NoComplete)
    config.MakeCommand("include", Include, buffer.FileComplete)
    config.MakeCommand("insert", Insert, config.NoComplete)
    config.MakeCommand("jump", Jump, JumpComplete)
    config.MakeCommand("explore", Explore, config.NoComplete)
    config.MakeCommand("case", Case, CaseComplete)
    config.MakeCommand("pipe", Pipe, config.NoComplete)
    config.MakeCommand("shell", Shell, config.NoComplete)
    config.MakeCommand("run", Run, config.NoComplete)
    config.MakeCommand("join", Join, config.NoComplete)

    config.MakeCommand("switchtab", SwitchTab, config.NoComplete)
    config.MakeCommand("?", Help, config.NoComplete)
end
