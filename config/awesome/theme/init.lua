local beautiful = require("beautiful")

local theme = require("theme.configuration")

beautiful.init(theme)

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