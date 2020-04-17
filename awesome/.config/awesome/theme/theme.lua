local themeAssets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

local icons = require("theme.icons")
local layoutIcons = require("theme.icons.layouts")
local wallpapers = require("theme.wallpapers")

local theme = {}

theme.font = "sans 8"

theme.bg_focus = xrdb.color12
theme.bg_minimize = xrdb.color8
theme.bg_normal = xrdb.background
theme.bg_systray = theme.bg_normal
theme.bg_urgent = xrdb.color9

theme.fg_focus = theme.bg_normal
theme.fg_minimize = theme.bg_normal
theme.fg_normal = xrdb.foreground
theme.fg_urgent = theme.bg_normal

theme.border_focus  = theme.bg_focus
theme.border_marked = xrdb.color10
theme.border_normal = xrdb.color0
theme.border_width  = dpi(2)
theme.useless_gap   = dpi(3)

theme.tooltip_fg = theme.fg_normal
theme.tooltip_bg = theme.bg_normal

-- Variables set for theming the menu:
theme.menu_submenu_icon = icons.submenu
theme.menu_height = dpi(16)
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

-- Recolor Layout icons:
theme = themeAssets.recolor_layout(theme, theme.fg_normal)

-- Generate Awesome icon:
theme.awesome_icon = themeAssets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Generate taglist squares:
local taglistSquareSize = dpi(4)
theme.taglist_squares_sel = themeAssets.taglist_squares_sel(
    taglistSquareSize, theme.fg_normal
)
theme.taglist_squares_unsel = themeAssets.taglist_squares_unsel(
    taglistSquareSize, theme.fg_normal
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme