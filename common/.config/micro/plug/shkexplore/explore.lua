NAME = "shk-explore"
VERSION = "1.3.0"

local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local shell = import("micro/shell")
local util = import("micro/util")
local strings = import("strings")
local ioutil = import("io/ioutil")
local filepath = import("path/filepath")
local os = import("os")

function Explore(bp, args)
    local path = filepath.Join(os.Getwd() or "", "$"):sub(1, -2)
    local out, err = shell.RunInteractiveShell("bash -c '" .. table.concat({
        "fd . --type=f --color=never | sort --uniq | sed \'/^$/d\'",
        "fzf --no-info --header-first --header \'" .. path .. "\' --height=100% --color=16 --prompt=\"  \" --preview \"bat --color=always {}\""
    }, " | ") .. "'", false, true)
    if err then
        local cancelled = tostring(err):match(" 130$")
        if cancelled then return else return micro.InfoBar():Error(tostring(err)) end
    end
    path = filepath.Join(path, out)
    micro.InfoBar():GutterMessage(path)
    bp:HandleCommand("tab " .. path)
end

function init()
    config.MakeCommand("explore", Explore, config.NoComplete)
    config.TryBindKey("Ctrl-o", "command:explore", false)
end
