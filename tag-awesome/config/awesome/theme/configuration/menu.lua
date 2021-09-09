local dpi = require("beautiful.xresources").apply_dpi
local themeAssets = require("beautiful.theme_assets")

local Helper = require("theme.configuration.helper")
local layoutIcons = require("theme.icons.layouts")

local function init(theme)
    --* Menu Style
    theme.menu_border_width = theme.gtk.button_border_width
    theme.menu_border_color = theme.gtk.menubar_border_color
    theme.menu_bg_normal = theme.gtk.menubar_bg_color
    theme.menu_fg_normal = theme.gtk.menubar_fg_color

    theme.menu_height = dpi(24)
    theme.menu_width  = dpi(150)
    theme.menu_submenu_icon = nil
    theme.menu_submenu = "▸ "

    theme.tooltip_fg = theme.gtk.tooltip_fg_color
    theme.tooltip_bg = theme.gtk.tooltip_bg_color

    theme.bg_systray = theme.wibar_bg

    --* Awesome Icon
    theme.awesome_icon = themeAssets.awesome_icon(
        theme.menu_height, Helper:mix(theme.bg_focus, theme.fg_normal), theme.wibar_bg
    )

    --* Layout Icons
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

    -- Recolor Layout icons
    theme = themeAssets.recolor_layout(theme, theme.wibar_fg)
end

return init