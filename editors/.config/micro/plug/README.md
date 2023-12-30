function my(bp, args)
    bp.Cursor:HasSelection()
    bp.Buf:GetCursor()
    start = bp.Cursor:CurSelection[1]
    end = bp.Cursor:CurSelection[2]
    util.String(cursor:GetSelection())
    stdout, stderr = shell.RunCommand()
    micro.InfoBar():Message("")
    micro.InfoBar():Error("")
    micro.InfoBar():YNPrompt("?", function (boolean, cancelled) end)
end
