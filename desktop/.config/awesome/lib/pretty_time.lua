local pretty_time_words = {"one ", "two ", "three ", "four ", "five ", "six ", "seven ", "eight ", "nine "}
local pretty_time_levels = {"thousand ", "million ", "billion ", "trillion ", "quadrillion ", "quintillion ", "sextillion ", "septillion ", "octillion ", [0] = ""}
local pretty_time_iwords = {"ten ", "twenty ", "thirty ", "forty ", "fifty ", "sixty ", "seventy ", "eighty ", "ninety "}
local pretty_time_twords = {"eleven ", "twelve ", "thirteen ", "fourteen ", "fifteen ", "sixteen ", "seventeen ", "eighteen ", "nineteen "}

local function pretty_time_digits(n)
    local i, ret = -1
    return function()
        i, ret = i + 1, n % 10
        if n > 0 then
            n = math.floor(n / 10)
            return i, ret
        end
    end
end

local pretty_time_level = false
function pretty_time_getname(pos, dig)
  pretty_time_level = pretty_time_level or pos % 3 == 0
  if (dig == 0) then return "" end
  local name = (pos % 3 == 1 and pretty_time_iwords[dig] or pretty_time_words[dig]) .. (pos % 3 == 2 and "hundred " or "")
  if (level) then name, level = name .. pretty_time_levels[math.floor(pos / 3)], false end
  return name
end

function pretty_time_number2word(number)
    if(number == 0) then return "zero" end
    vword = ""
    for i, v in pretty_time_digits(number) do
        vword = pretty_time_getname(i, v) .. vword
    end

    for i, v in ipairs(pretty_time_words) do
        vword = vword:gsub("ty " .. v, "ty-" .. v)
        vword = vword:gsub("ten " .. v, pretty_time_twords[i])
    end
    return vword
end

return function()
    hour = os.date("%H") + 0
    minute = os.date("%M") + 0
    hour = hour % 12
    if(hour == 0) then
        hour, nextHourWord = 12, "one "
    else
        nextHourWord = pretty_time_number2word(hour+1)
    end
    hourWord = pretty_time_number2sord(hour)
    if(minute <= 3) then
       return hourWord .. "o'clock"
    elseif(minute >= 58) then
       return nextHourWord .. "o'clock"
    elseif(minute == 0) then
       return hourWord .. "o'clock"
    elseif(minute >= 3 and minute <= 7) then
       return "five past " .. hourWord
    elseif(minute >= 8 and minute <= 12) then
       return "ten past " .. hourWord
    elseif(minute >= 13 and minute <= 17) then
       return "a quarter past " .. hourWord
    elseif(minute >= 18 and minute <= 22) then
       return "twenty past " .. hourWord
    elseif(minute >= 23 and minute <= 27) then
       return "twenty-five past " .. hourWord
    elseif(minute >= 28 and minute <= 32) then
       return "half past " .. hourWord
    elseif(minute >= 33 and minute <= 37) then
       return "twenty-five to " .. nextHourWord
    elseif(minute >= 38 and minute <= 42) then
       return "twenty to " .. nextHourWord
    elseif(minute >= 43 and minute <= 47) then
       return "a quarter to " .. nextHourWord
    elseif(minute >= 48 and minute <= 52) then
       return "ten to " .. nextHourWord
    elseif(minute >= 53 and minute <= 60) then
       return "five to " .. nextHourWord
    else
        if(minute < 30) then
            return pretty_time_number2word(minute) .. "minutes past " .. hourWord
        else
            return pretty_time_number2word(60-minute) .. "minutes to " .. nextHourWord
        end
    end
end
