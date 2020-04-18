local Helper = require("theme.configuration.helper")

local function init(theme)
    theme.taglist_shape_container = Helper.roundedRectShape
    theme.taglist_shape_clip_container = true
    theme.taglist_shape_border_width_container = theme.gtk.button_border_width * 2
    theme.taglist_shape_border_color_container = theme.gtk.header_button_border_color

    theme.taglist_bg_occupied = theme.gtk.header_button_bg_color
    theme.taglist_fg_occupied = theme.gtk.header_button_fg_color

    theme.taglist_bg_empty = Helper:mix(
        theme.gtk.menubar_bg_color,
        theme.gtk.header_button_bg_color,
        0.3
    )
    theme.taglist_fg_empty = Helper:mix(
        theme.gtk.menubar_bg_color,
        theme.gtk.header_button_fg_color
    )

    theme.taglist_squares_sel = nil
    theme.taglist_squares_unsel = nil
end

return init