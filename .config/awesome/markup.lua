-- https://github.com/lcpz/lain/blob/master/util/markup.lua

local markup = {}

markup.bold = function (text)
  return string.format("<b>%s</b>", text)
end

markup.italic = function (text)
  return string.format("<i>%s</i>", text)
end

markup.strike = function (text)
  return string.format("<s>%s</s>", text)
end

markup.underline = function (text)
  return string.format("<u>%s</u>", text)
end

markup.big = function (text)
  return string.format("<big>%s</big>", text)
end

markup.small = function (text)
  return string.format("<small>%s</small>", text)
end

markup.fg = function (fg, text)
  return string.format("<span foreground='%s'>%s</span>", fg, text)
end

markup.bg = function (bg, text)
  return string.format("<span background='%s'>%s</span>", bg, text)
end

markup.fgbg = function (fg, bg, text)
  return string.format("<span foreground='%s' background='%s'>%s</span>", fg, bg, text)
end

markup.bgfg = function (bg, fg, text)
  return string.format("<span foreground='%s' background='%s'>%s</span>", fg, bg, text)
end

return markup
