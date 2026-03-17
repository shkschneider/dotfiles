NAME = "shkcore"
VERSION = "1.5.0"

local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local shell = import("micro/shell")
local util = import("micro/util")
local strings = import("strings")
local ioutil = import("io/ioutil")
local filepath = import("path/filepath")
local os = import("os")

function _Prompt(prompt, text, name, callback)
    micro.InfoBar():Prompt(" " .. prompt .. ": ", text, name, null, function (out, cancelled)
        if cancelled then return end
        callback(out)
    end)
end

function _Replace(old, new)
    micro.InfoBar():Message(old .. " -> " .. new)
    bp:HandleCommand("replaceall " .. old .. " " .. new)
end

function Replace(bp, args)
    if not bp.Cursor:HasSelection() then return micro.InfoBar():Message("No selection") end
    local old = util.String(bp.Cursor:GetSelection())
    micro.InfoBar():Prompt("Replace " .. old .. " by", "", "Replace", nil, function (out, cancelled)
        if cancelled then return end
        _Replace(old, new)
    end)
    bp.Cursor:ResetSelection()
end

-- TODO bp: RunCmd EvalCmd RawCmd

function RunCommand(bp, command)
    if #command == 0 then
        return
    elseif command:find("{}") then -- TODO test
        micro.InfoBar():Prompt("Run", "", "Command", nil, function (out, cancelled)
            if cancelled then return end
            out = strings.TrimSpace(out)
            RunCommand(bp, out)
        end)
    else
        micro.InfoBar():Message(command:match("^%w+") .. ": " .. command)
        bp:HandleCommand(command)
    end
end

function QuickRun(bp, args)
    local path = filepath.Join(config.ConfigDir, "plug", NAME, "*.list")
    local out, err = shell.RunInteractiveShell("bash -c 'cat " .. path .. " | fzf --height=100%'", false, true)
    if err then return micro.InfoBar():Error(tostring(err)) end
    RunCommand(bp, strings.TrimSpace(out):match("([^#]*) ?#"))
end

function Command(bp, args)
    micro.InfoBar():Prompt("Run: ", "", "Command", nil, function (out, cancelled)
        if cancelled then return end
        RunCommand(bp, out)
    end)
end

function NextOccurence(bp, args)
    if not bp.Cursor then return micro.InfoBar():Error("No cursor") end
    if bp.Cursor:HasSelection() then
        local query = util.String(bp.Cursor:GetSelection())
        local _, err = bp:Search(query, false, true)
        if not err then
            bp:WordRight()
            bp:CursorLeft()
            bp.Cursor:Deselect(true)
        end
    elseif util.IsWordChar(util.RuneAt(bp.Buf:LineBytes(bp.Cursor.Y), bp.Cursor.X)) then
        bp.Cursor:SelectWord()
        NextOccurence(bp, args)
    end
end

function Test(bp, args)
    local msg = buffer.NewMessageAtLine("+", "THIS IS A MESSAGE", bp.Cursor.Loc.Y + 1, buffer.MTInfo)
    bp.Buf:AddMessage(msg)
end

function KeyBind(bp, args)
    micro.InfoBar():Prompt("? ", "", "Keybind", nil, function (out, cancelled)
        if cancelled then return end
        micro.InfoBar():Message(out)
    end)
end
function KeyBindComplete()
    local t = { "Save" }
    return t, t
end

function init()
    config.MakeCommand("test", Test, config.NoComplete)
    config.TryBindKey("Ctrl-Backslash", "ShellMode", false)
    config.MakeCommand("command", Command, OptionComplete)
    config.TryBindKey("Ctrl-Space", "command:command", false)
    config.MakeCommand("replace", Replace, config.NoComplete)
    config.TryBindKey("Ctrl-r", "command:replace", false)
    config.MakeCommand("keybind", KeyBind, KeyBindComplete)
    config.TryBindKey("Ctrl-k", "command-edit:keybind", false)
    config.MakeCommand("nextoccurence", NextOccurence, config.NoComplete)
    --config.MakeCommand("quickrun", QuickRun, config.NoComplete)
    --config.TryBindKey("Ctrl-t", "command:quickrun", true)
end
