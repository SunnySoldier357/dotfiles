local gtk = require("beautiful.gtk")
local dpi = require("beautiful.xresources").apply_dpi

local Helper = require("theme.configuration.helper")

local function createThemeWithGtk()
    local theme = {}

    theme.gtk = gtk.get_theme_variables()

    theme.gtk.bold_font = theme.gtk.font_family .. " Bold " .. theme.gtk.font_size

    theme.gtk.button_border_radius = dpi(theme.gtk.button_border_radius or 0)
    theme.gtk.button_border_width = dpi(theme.gtk.button_border_width or 1)

    theme.gtk.menubar_border_color = Helper:mix(
        theme.gtk.menubar_bg_color,
        theme.gtk.menubar_fg_color,
        0.7
)

    return theme
end

return createThemeWithGtk