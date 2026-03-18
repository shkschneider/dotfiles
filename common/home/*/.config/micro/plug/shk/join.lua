local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local util = import("micro/util")

function Join(bp, args)
    local sep = nil
    if args ~= nil and #args >= 1 then
        sep = tostring(args[1])
    end
    local beginning = buffer.Loc(bp.Cursor.Loc.X, bp.Cursor.Loc.Y)
    local ending = buffer.Loc(bp.Cursor.Loc.X, bp.Cursor.Loc.Y)
    if bp.Cursor:HasSelection() then
        if bp.Cursor.CurSelection[1]:GreaterThan(-bp.Cursor.CurSelection[2]) then
            beginning = buffer.Loc(bp.Cursor.CurSelection[2].X, bp.Cursor.CurSelection[2].Y)
            ending = buffer.Loc(bp.Cursor.CurSelection[1].X, bp.Cursor.CurSelection[1].Y)
        else
            beginning = buffer.Loc(bp.Cursor.CurSelection[1].X, bp.Cursor.CurSelection[1].Y)
            ending = buffer.Loc(bp.Cursor.CurSelection[2].X, bp.Cursor.CurSelection[2].Y)
        end
    else
        beginning = buffer.Loc(0, bp.Cursor.Loc.Y)
        ending = buffer.Loc(string.len(bp.Buf:Line(bp.Cursor.Loc.Y + 1)), bp.Cursor.Loc.Y + 1)
    end
    bp.Cursor:SetSelectionStart(beginning)
    bp.Cursor:SetSelectionEnd(ending)
    local text = util.String(bp.Cursor:GetSelection()):gsub("%s*\n%s+", sep or " "):gsub("%s*\n%s*", sep or "")
    bp.Buf:Replace(beginning, ending, text)
end
