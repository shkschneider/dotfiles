NAME = "rocket"
VERSION = "1.0.0"

local micro = import("micro")
local config = import("micro/config")
local shell = import("micro/shell")
local buffer = import("micro/buffer")
local util = import("micro/util")
local strings = import("strings")

local rocket = {}

function rocket.edit(bp, args)
    local filepath = import("path/filepath")
    local os = import("os")

    local path = filepath.Join(config.ConfigDir, "plug", NAME, bp.Buf:FileType() .. ".list")
    local info, err = os.Stat(path)
    if err or info:IsDir() then
        path = filepath.Join(config.ConfigDir, "plug", NAME, NAME .. ".list")
    end
    bp:HandleCommand("tab " .. path)
end

function rocket.run(bp, args)
    local filepath = import("path/filepath")
    local path = filepath.Join(config.ConfigDir, "plug", NAME, "*.list")
    local out, err = shell.RunInteractiveShell("bash -c 'cat " .. path .. " | fzf --select-1 --print-query'", false, true)
    out = strings.TrimSpace(out)
    if #out == 0 then return end
    local cmd = out:match("^%w+")
    micro.InfoBar():Message("Run: " .. out)
    out, err = shell.RunCommand(out)
    if err then
        micro.InfoBar():Error(cmd .. ": " .. tostring(err))
        return
    end
    out = out:match(".*\s*$")
    micro.InfoBar():Message(cmd .. ": " .. out)
end

function rocket.replace(bp, args)
    local search = nil
    local replace = nil
    if not bp.Cursor:HasSelection() then
        micro.InfoBar():Error("No selection")
        return
    end
    search = util.String(bp.Cursor:GetSelection())
    local out, err = micro.InfoBar():Prompt("Replace '" .. search .. "' by: ", "", "", nil, function(out, cancelled)
        if cancelled then return end
        replace = strings.TrimSpace(out)
        bp:HandleCommand("replaceall '" .. search .. "' '" .. replace .. "'")
        micro.InfoBar():Message(search .. "->" .. replace)
        bp.Cursor:ResetSelection()
    end)
end

function rocket.init()
    config.MakeCommand("rocket-edit", rocket.edit, config.NoComplete)
    config.TryBindKey("Alt-Ctrl-Space", "command:rocket-build", false)
    config.MakeCommand("rocket-run", rocket.run, config.NoComplete)
    config.TryBindKey("Ctrl-Space", "command:rocket-launch", false)
    config.MakeCommand("rocket-replace", rocket.replace, config.NoComplete)
    config.TryBindKey("Ctrl-t", "command:rocket-dock", false)
end

function init()
    rocket.init()
end
