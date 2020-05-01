local dpi = require("beautiful.xresources").apply_dpi

local Helper = require("theme.configuration.helper")

local function init(theme)
    --* Font
    theme.font = theme.gtk.font_family .. " " .. theme.gtk.font_size

    --* Colors
    theme.bg_normal = theme.gtk.bg_color
    theme.fg_normal = theme.gtk.fg_color

    theme.bg_focus = theme.gtk.selected_bg_color
    theme.fg_focus = theme.gtk.selected_fg_color

    theme.bg_urgent = theme.gtk.error_bg_color
    theme.fg_urgent = theme.gtk.error_fg_color

    theme.wibar_bg = theme.gtk.menubar_bg_color
    theme.wibar_fg = theme.gtk.menubar_fg_color

    theme.bg_minimize = Helper:mix(theme.wibar_fg, theme.wibar_bg, 0.3)
    theme.fg_minimize = Helper:mix(theme.wibar_fg, theme.wibar_bg, 0.9)

    --* Borders
    theme.border_focus = theme.gtk.wm_border_focused_color
    theme.border_marked = theme.gtk.success_color
    theme.border_normal = theme.gtk.wm_border_unfocused_color

    theme.border_radius = theme.gtk.button_border_radius
    theme.border_width = dpi(theme.gtk.button_border_width or 1)

    theme.useless_gap = dpi(3)
end

return init