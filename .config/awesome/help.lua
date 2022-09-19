help = require("awful.hotkeys_popup")

function helpkey(key)
  if key.m and key.k and key.g and key.d and key.d then
    local keys = {}
    keys[key.k] = key.d
    help.widget.add_hotkeys {
      [key.g] = {
        { modifiers = key.m, keys = keys }
      }
    }
    return awful.key(key.m, key.k, key.f)
  else
    return key
  end
end
