local beautiful = require("beautiful")
local gears = require("gears")

local configDir = require("gears.filesystem").get_configuration_dir()

beautiful.init(configDir .. "theme/theme.lua")

client.connect_signal("focus",
    function(client)
        client.border_color = beautiful.border_focus
    end
)
client.connect_signal("unfocus",
    function(client)
        client.border_color = beautiful.border_normal
    end
)