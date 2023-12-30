function math.clamp(v, min, max)
    if v < min then return min end
    if v > max then return max end
    return v
end
