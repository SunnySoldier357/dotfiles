local beautiful = require("beautiful")

-- Initialize icons array and load icon theme
local icon_themes = {
    "linebit",        -- 1 -- Neon + outline
    "drops",          -- 2 -- Pastel + filled
}
local icon_theme = icon_themes[2]

local icons = require("theme.icons.apps")
icons.init(icon_theme)

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