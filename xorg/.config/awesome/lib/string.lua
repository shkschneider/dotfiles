function string.trim(s)
    return string.match(s, '^()%s*$') and '' or string.match(s, '^%s*(.*%S)')
end

function string.split(str, c)
    c = c or "%s"
    local t = {}
    for s, _ in string.gmatch(str, "([^" .. c .. "]*)(" .. c .. "?)") do
        table.insert(t, s)
        --if s == "" then return t end
    end
    if #t == 1 and t[1] == "" then return {} end
    return t
end

function string.findlast(str, s)
    local i = str:match(".*" .. s .. "()")
    if not i then return nil else return i -1 end
end

function string.ascii(str, s)
    return str and string.gsub(str, "[^\000-\127]", s or "")
end

function string.ellipsize(str, l)
    local dots = "..."
    if not str or not type(l) == "number" or #str < l - #dots then return str end
    return str:sub(1, l) .. dots
end
