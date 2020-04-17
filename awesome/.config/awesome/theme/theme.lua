local themeAssets = require("beautiful.theme_assets")
local dpi = require("beautiful.xresources").apply_dpi

local icons = require("theme.icons")
local layoutIcons = require("theme.icons.layouts")
local wallpapers = require("theme.wallpapers")

local theme = {}

theme.font = "sans 8"

theme.bg_focus = "#535D6C"
theme.bg_minimize = "#444444"
theme.bg_normal = "#222222"
theme.bg_systray = theme.bg_normal
theme.bg_urgent = "#FF0000"

theme.fg_focus      = "#FFFFFF"
theme.fg_minimize   = "#FFFFFF"
theme.fg_normal     = "#AAAAAA"
theme.fg_urgent     = "#FFFFFF"

theme.border_focus  = "#535D6C"
theme.border_marked = "#91231C"
theme.border_normal = "#000000"
theme.border_width  = dpi(1)
theme.useless_gap   = dpi(0)

-- Generate taglist squares:
local taglistSquareSize = dpi(4)
theme.taglist_squares_sel = themeAssets.taglist_squares_sel(
    taglistSquareSize, theme.fg_normal
)
theme.taglist_squares_unsel = themeAssets.taglist_squares_unsel(
    taglistSquareSize, theme.fg_normal
)

-- Variables set for theming the menu:
theme.menu_submenu_icon = icons.submenu
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.wallpaper = wallpapers.default

-- Layout Icons
theme.layout_fairh = layoutIcons.fairhw
theme.layout_fairv = layoutIcons.fairvw
theme.layout_floating  = layoutIcons.floatingw
theme.layout_magnifier = layoutIcons.magnifierw
theme.layout_max = layoutIcons.maxw
theme.layout_fullscreen = layoutIcons.fullscreenw
theme.layout_tilebottom = layoutIcons.tilebottomw
theme.layout_tileleft   = layoutIcons.tileleftw
theme.layout_tile = layoutIcons.tilew
theme.layout_tiletop = layoutIcons.tiletopw
theme.layout_spiral  = layoutIcons.spiralw
theme.layout_dwindle = layoutIcons.dwindlew
theme.layout_cornernw = layoutIcons.cornernww
theme.layout_cornerne = layoutIcons.cornernew
theme.layout_cornersw = layoutIcons.cornersww
theme.layout_cornerse = layoutIcons.cornersew

-- Generate Awesome icon:
theme.awesome_icon = themeAssets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme