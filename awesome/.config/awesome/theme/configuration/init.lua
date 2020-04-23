local initFontsColors = require("theme.configuration.fontscolors")
local createThemeWithGtk = require("theme.configuration.gtk")
local initMenu = require("theme.configuration.menu")
local initTaglist = require("theme.configuration.taglist")
local initTasklist = require("theme.configuration.tasklist")
local wallpapers = require("theme.wallpapers")

require("theme.configuration.extras")

local theme = createThemeWithGtk()

theme.wallpaper = wallpapers.default

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

initFontsColors(theme)
initTasklist(theme)
initTaglist(theme)
initMenu(theme)

return theme