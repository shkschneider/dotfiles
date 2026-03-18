local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local util = import("micro/util")

local cases = { "camel", "pascal", "kebab", "snake", "upper", "lower", "reverse", "increment", "decrement", "title" }

function Case(bp, args)
    local c = bp.Cursor
    if not c:HasSelection() then
        micro.InfoBar():Error("No selection")
        return
    end
    local selection = util.String(bp.Cursor:GetSelection())
    if #args == 0 then return micro.InfoBar():Error("Which case?") end
    local case, s = tostring(args[1]), nil
    if case == "c" or case == "camel" then
        micro.InfoBar():GutterMessage("camelCase")
        local p = selection:gsub("[^%w]", " "):gsub("(%w+)", function (w)
            return w:sub(1, 1):upper() .. w:sub(2, -1):lower()
        end):gsub("%s+", "")
        s = p:sub(1, 1):lower() .. p:sub(2, -1)
    elseif case == "p" or case == "pascal" then
        micro.InfoBar():GutterMessage("PascalCase")
        s = selection:gsub("[^%w]", " "):gsub("(%w+)", function (w)
            return w:sub(1, 1):upper() .. w:sub(2, -1):lower()
        end):gsub("%s+", "")
    elseif case == "k" or case == "kebab" then
        micro.InfoBar():GutterMessage("kebab-case")
        s = selection:lower():gsub("[^%w]", "_"):gsub("_+", "-")
    elseif case == "s" or case == "snake" then
        micro.InfoBar():GutterMessage("snake_case")
        s = selection:lower():gsub("[^%w]", "_"):gsub("__+", "_")
    elseif case == "u" or case == "upper" then
        micro.InfoBar():GutterMessage("UPPERCASE")
        s = selection:upper()
    elseif case == "l" or case == "lower" then
        micro.InfoBar():GutterMessage("lowercase")
        s = selection:lower()
    elseif case == "r" or case == "reverse" then
        micro.InfoBar():GutterMessage("rEVERSEcASE")
        s = selection:gsub("%a", function (c)
            if c == c:upper() then return c:lower() else return c:upper() end
        end)
    elseif case == "i" or case == "increment" then
        micro.InfoBar():GutterMessage("increment")
        s = tostring(tonumber(selection) + 1)
    elseif case == "d" or case == "decrement" then
        micro.InfoBar():GutterMessage("decrement")
        s = tostring(tonumber(selection) - 1)
    elseif case == "t" or case == "title" then
        micro.InfoBar():GutterMessage("Title case")
        s = selection:gsub("%a+", function(char) return char:sub(1, 1):upper() .. char:sub(2) end)
    else
        return micro.InfoBar():Error("Not implemented: " .. tostring(case))
    end
    bp.Cursor:DeleteSelection()
    bp.Buf:Insert(buffer.Loc(bp.Cursor.Loc.X, bp.Cursor.Loc.Y), s)
end

function CaseComplete()
    local t = {}
    for i, case in ipairs(cases) do
        t[i] = case
    end
    return t, t
end
