local micro = import("micro")
local shell = import("micro/shell")

function Shell(bp, args)
    micro.InfoBar():Prompt("Shell: ", "", "Shell", nil, function (out, cancelled)
        if cancelled then return end
        shell.RunInteractiveShell(out, true, false)
    end)
end
