require("module.autostart")

local notification_themes = {
    "lovelace",       -- 1 -- Plain with standard image icons
    "ephemeral",      -- 2 -- Outlined text icons and a rainbow stripe
    "amarena",        -- 3 -- Filled text icons on the right, text on the left
}
local notification_theme = notification_themes[3]

local notifications = require("module.notifications")
notifications.init(notification_theme)