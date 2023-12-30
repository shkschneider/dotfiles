require "init"

-- nice (my lib)
nice = require "lib.nice"
require("src.theme")("mytheme")

-- src
require "src.keyboard"
require "src.mouse"
require "src.layouts"
require "src.panels"
require "src.dashboard"
require "src.windows"
require "src.navigation"
root.keys(globalkeys or {})
root.buttons(globalbuttons or {})
require "src.rules"

-- autostart
-- TODO nice.autostart()
nice.a.sync("sh " .. nice.places.config .. "autostart.sh")
