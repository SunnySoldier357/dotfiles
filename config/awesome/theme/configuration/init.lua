local initFontsColors = require("theme.configuration.fontscolors")
local initNotifications = require("theme.configuration.notifications")
local initTag = require("theme.configuration.tag")
local initWidgets = require("theme.configuration.widgets")
local wallpapers = require("theme.wallpapers")

local theme = {}

theme.wallpaper = wallpapers.default

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "/usr/share/icons/Numix"

initFontsColors(theme)
initNotifications(theme)
initWidgets(theme)
initTag(theme)

return theme