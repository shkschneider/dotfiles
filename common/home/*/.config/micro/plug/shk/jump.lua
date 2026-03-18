local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local shell = import("micro/shell")

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

function _JumpVertically(bp, dir)
    bp.Cursor:Deselect(true)
    if not _SameIndentation(bp, dir) then
        if not _EmptyLine(bp, dir) then
            _HalfPage(bp, dir)
        end
    end
    bp.Cursor:StartOfText()
    bp:Center()
end

function _JumpHorizontally(bp, dir)
    local c = bp.Cursor
    c:Deselect(true)
    local line = bp.Buf:Line(c.Y)
    local line_start = string.find(line, "%S") or 0
    local line_end = string.len(line)
    if dir > 0 then
        if c.X < line_start - 1 then
            c:StartOfText()
        elseif c.X == line_end then
            --c:Start()
            c:Down()
            c:StartOfText()
        else
            c.X = string.find(line, " ", c.X + 1, false) or string.len(line)
        end
    else
        if c.X < line_start then
            --c:Start()
            c:Up()
            c:End()
        else
            local x = string.find(string.reverse(string.sub(line, 0, c.X - 1)), " ") or 0
            if x ~= nil then
                c.X = c.X - x
            end
        end
    end
end

function _JumpToSymbol(bp)
    local out, err = shell.RunInteractiveShell(string.format(
        "bash -c \"ctags -f - --sort=no --fields=n '%s' | fzf --layout=reverse|tr ':' '\n' | tail -1\""
    , bp.Buf.Path), false, true)
    if err == nil and tonumber(out) ~= nil then
        bp.Cursor.X = 0
        bp.Cursor.Y = tonumber(out) - 1
        if not bp.Cursor:HasSelection() then
            bp.Cursor:SelectWord()
        end
    end
end

function Jump(bp, args)
    if args == nil or #args == 0 then
        _JumpToSymbol(bp)
    elseif args[1] == "top" then
        bp:SelectAll()
        bp:CursorLeft()
    elseif args[1] == "above" then
        if not bp.Cursor then return micro.InfoBar():Error("No cursor") end
        _JumpVertically(bp, -1)
    elseif args[1] == "below" then
        if not bp.Cursor then return micro.InfoBar():Error("No cursor") end
        _JumpVertically(bp, 1)
    elseif args[1] == "bottom" then
        bp:SelectAll()
        bp:CursorRight()
    elseif args[1] == "left" then
        _JumpHorizontally(bp, -1)
    elseif args[1] == "right" then
        _JumpHorizontally(bp, 1)
    else
        _JumpToSymbol(bp)
    end
end

function JumpComplete()
    local t = { "top", "above", "below", "bottom", "symbol..." }
    return t, t
end
