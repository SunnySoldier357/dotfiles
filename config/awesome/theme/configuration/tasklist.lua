local clientIcon = require("awful.widget.clienticon")
local dpi = require("beautiful.xresources").apply_dpi
local wibox = require("wibox")

local Helper = require("theme.configuration.helper")

local function init(theme)
    theme.tasklist_fg_normal = theme.wibar_fg
    theme.tasklist_bg_normal = theme.wibar_bg
    theme.tasklist_fg_focus = theme.tasklist_fg_normal
    theme.tasklist_bg_focus = theme.tasklist_bg_normal

    theme.tasklist_font_focus = theme.gtk.bold_font

    theme.tasklist_shape_minimized = Helper.roundedRectShape
    theme.tasklist_shape_border_color_minimized = Helper:mix(
        theme.bg_minimize,
        theme.fg_minimize,
        0.85
    )
    theme.tasklist_shape_border_width_minimized = theme.gtk.button_border_width

    theme.tasklist_spacing = theme.gtk.button_border_width

    theme.tasklist_widget_template =
    {
        {
            {
                {
                    {
                        id = "clienticon",
                        widget = clientIcon,
                    },
                    margins = dpi(4),
                    widget = wibox.container.margin,
                },
                {
                    id = "text_role",
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left = dpi(2),
            right = dpi(4),
            widget = wibox.container.margin
        },
        id = "background_role",
        widget = wibox.container.background,
        create_callback =
            function(self, c)
                self:get_children_by_id("clienticon")[1].client = c
            end,
    }
end

return init