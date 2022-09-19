-- https://notabug.org/PieceMaker/awesome/raw/master/prettytime.lua

words = {"one ", "two ", "three ", "four ", "five ", "six ", "seven ", "eight ", "nine "}
levels = {"thousand ", "million ", "billion ", "trillion ", "quadrillion ", "quintillion ", "sextillion ", "septillion ", "octillion ", [0] = ""}
iwords = {"ten ", "twenty ", "thirty ", "forty ", "fifty ", "sixty ", "seventy ", "eighty ", "ninety "}
twords = {"eleven ", "twelve ", "thirteen ", "fourteen ", "fifteen ", "sixteen ", "seventeen ", "eighteen ", "nineteen "}

function digits(n)
  local i, ret = -1
  return function()
    i, ret = i + 1, n % 10
    if n > 0 then
      n = math.floor(n / 10)
      return i, ret
    end
  end
end

level = false
function getname(pos, dig)
  level = level or pos % 3 == 0
  if(dig == 0) then return "" end
  local name = (pos % 3 == 1 and iwords[dig] or words[dig]) .. (pos % 3 == 2 and "hundred " or "")
  if(level) then name, level = name .. levels[math.floor(pos / 3)], false end
  return name
end

function numberToWord(number)
    if(number == 0) then return "zero" end
    vword = ""
    for i, v in digits(number) do
      vword = getname(i, v) .. vword
    end

    for i, v in ipairs(words) do
      vword = vword:gsub("ty " .. v, "ty-" .. v)
      vword = vword:gsub("ten " .. v, twords[i])
    end
    return vword
end

function conky_awesomeTime()
    hour = os.date("%H") + 0
    minute = os.date("%M") + 0
    hour = hour % 12
    if(hour == 0) then 
        hour, nextHourWord = 12, "one " 
    else
        nextHourWord = numberToWord(hour+1)
    end
    hourWord = numberToWord(hour)
    if(minute <= 3) then 
       return hourWord .. "o'clock"
    elseif(minute >= 58) then 
       return nextHourWord .. "o'clock"
    elseif(minute == 0) then 
       return hourWord .. "o'clock"
    elseif(minute >= 3 and minute <= 7) then
       return "five past \n " .. hourWord
    elseif(minute >= 8 and minute <= 12) then
       return "ten past \n " .. hourWord
    elseif(minute >= 13 and minute <= 17) then
       return "a quarter \n past " .. hourWord
    elseif(minute >= 18 and minute <= 22) then
       return "twenty \n past " .. hourWord
    elseif(minute >= 23 and minute <= 27) then
       return "twenty-five \n past " .. hourWord
    elseif(minute >= 28 and minute <= 32) then
       return "half past \n " .. hourWord
    elseif(minute >= 33 and minute <= 37) then
       return "twenty-five \n to " .. nextHourWord
    elseif(minute >= 38 and minute <= 42) then
       return "twenty \n to " .. nextHourWord
    elseif(minute >= 43 and minute <= 47) then
       return "a quarter \n to " .. nextHourWord
    elseif(minute >= 48 and minute <= 52) then
       return "ten to \n " .. nextHourWord
    elseif(minute >= 53 and minute <= 60) then
       return "five to \n " .. nextHourWord
    else
        if(minute < 30) then
            return numberToWord(minute) .. "minutes \n past " .. hourWord
        else
            return numberToWord(60-minute) .. "minutes \n to " .. nextHourWord
        end
    end
end
