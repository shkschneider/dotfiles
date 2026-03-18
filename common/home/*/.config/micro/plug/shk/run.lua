local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local shell = import("micro/shell")

function Run(bp)
    -- bp:Save()
    local type = bp.Buf:FileType()
    if type == "shell" then
        shell.RunInteractiveShell(string.format("bash -- %s", bp.Buf.Path), true, false)
    elseif type == "lua" then
        shell.RunInteractiveShell(string.format("lua -- %s", bp.Buf.Path), true, false)
    elseif type == "markdown" then
        shell.RunInteractiveShell(string.format("glow -- %s", bp.Buf.Path), true, false)
    elseif type == "go" then
        shell.RunInteractiveShell("go run .", true, false)
    elseif type == "c" then
        shell.RunInteractiveShell("make", true, false)
    else
        micro.InfoBar():Error("Unknown runner for " .. type .. "!")
        return
    end
    -- local out, err = shell.RunCommand(args[1] .. " -- " .. args[2])
    -- if err then return micro.InfoBar():Error(tostring(err)) end
    -- bp:HSplitIndex(buffer.NewBuffer(out, "/tmp/" .. args[1]), true)
end
