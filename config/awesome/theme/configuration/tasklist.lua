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
        widget = wibox.container.background,
        id = "background_role",
        create_callback =
            function(self, _client)
                self:get_children_by_id("clienticon")[1].client = _client
            end,
        {
            widget = wibox.container.margin,
            left = dpi(2),
            right = dpi(4),
            {
                layout = wibox.layout.fixed.horizontal,
                {
                    widget = wibox.container.margin,
                    margins = dpi(4),
                    {
                        id = "clienticon",
                        widget = clientIcon,
                    },
                },
                {
                    id = "text_role",
                    widget = wibox.widget.textbox,
                },
            },
        },
    }
end

return init