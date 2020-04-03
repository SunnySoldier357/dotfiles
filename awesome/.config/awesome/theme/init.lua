local beautiful = require("beautiful")
local gears = require("gears")

beautiful.init(gears.filesystem.get_themes_dir() .. "gtk/theme.lua")

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