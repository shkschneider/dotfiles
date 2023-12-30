local pretty_size_units = {
    [0] = "",
    [1] = "K",
    [2] = "M",
    [3] = "G",
    [4] = "T",
    [5] = "P",
    [6] = "E",
    [7] = "Z",
    [8] = "Y"
}

return function(n)
    if type(n) ~= "number" or n == 0 then return "0" end
    local u = math.floor(math.log(n) / math.log(1024))
    return math.floor(n / (1024 ^ u)) .. (pretty_size_units[u] or "")
end
