NAME = "shk-jump"
VERSION = "1.2.0"

local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")

function _HalfPage(bp, dir)
    if dir > 0 then
        bp:MoveCursorDown(bp:BufView().Height / 2)
    elseif dir < 0 then
        bp:MoveCursorUp(bp:BufView().Height / 2)
    end
end

function _EmptyLine(bp, dir)
    local c = bp.Cursor
    local x, y = c.Loc.X, c.Loc.Y
    local l, n = c.Loc.Y + dir, bp.Buf.LineArray:LinesNum()
    while l >= 1 and l < n do
        if l ~= y and #bp.Buf:Line(l):gsub("^%s+", "") == 0 then
            bp:GotoLoc(buffer.Loc(x, l))
            c:StartOfText()
            return true
        end
        l = l + dir
    end
    c:GotoLoc(buffer.Loc(x, y))
    return false
end

function _SameIndentation(bp, dir)
    local c = bp.Cursor
    c:StartOfText()
    local x, y = c.Loc.X, c.Loc.Y
    local l, n = c.Loc.Y + dir, bp.Buf.LineArray:LinesNum()
    while l >= 1 and l < n do
        c:GotoLoc(buffer.Loc(1, l))
        c:StartOfText()
        if l ~= y and c.Loc.X ~= x then
            break
        end
        l = l + dir
    end
    while l >= 1 and l < n do
        c:GotoLoc(buffer.Loc(1, l))
        c:StartOfText()
        if l ~= y and c.Loc.X == x then
            c:GotoLoc(buffer.Loc(1, l))
            bp:GotoLoc(buffer.Loc(x, l))
            return true
        end
        l = l + dir
    end
    bp:GotoLoc(buffer.Loc(x, y))
    return false
end

function _Jump(bp, dir)
    bp.Cursor:Deselect(true)
    if not _SameIndentation(bp, dir) then
        if not _EmptyLine(bp, dir) then
            _HalfPage(bp, dir)
        end
    end
    bp.Cursor:StartOfText()
    bp:Center()
end

function JumpAbove(bp, args)
    if not bp.Cursor then return micro.InfoBar():Error("No cursor") end
    _Jump(bp, -1)
end

function JumpBelow(bp, args)
    if not bp.Cursor then return micro.InfoBar():Error("No cursor") end
    _Jump(bp, 1)
end

function JumpRelative(bp, args)
    if #args == 0 then return micro.InfoBar():Error("No target") end
    local l, n = bp.Buf:LinesNum(), tonumber(args[1]:match("%d+"))
    if args[1]:sub(-1) == "%" then
        n = math.floor((n / 100) * l)
    end
    if not bp.Cursor then return micro.InfoBar():Error("No cursor") end
    local y = bp.Cursor.Loc.Y
    if args[1]:sub(1, 1) == "+" then
        y = y + n
    elseif args[1]:sub(1, 1) == "-" then
        y = y - n
    else
        y = n
    end
    if y < 1 then y = 1 end
    if y > l then y = l end
    bp:GotoLoc(buffer.Loc(bp.Cursor.Loc.X, y))
    bp.Cursor:Relocate()
    micro.InfoBar():GutterMessage("Jumped to line " .. y)
end

function JumpRelativeComplete()
    local t = { "1", "-10%", "50%", "+10%", "+99" }
    return t, t
end

function init()
    config.MakeCommand("jumpabove", JumpAbove, config.NoComplete)
    config.TryBindKey("Ctrl-Up", "command:jumpabove", false)
    config.MakeCommand("jumpbelow", JumpBelow, config.NoComplete)
    config.TryBindKey("Ctrl-Down", "command:jumpbelow", false)
    config.MakeCommand("jumprelative", JumpRelative, JumpRelativeComplete)
end
