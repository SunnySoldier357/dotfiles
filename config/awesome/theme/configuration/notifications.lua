local dpi = require("beautiful.xresources").apply_dpi

local x = require("theme.colors")

local function init(theme)
    -- Position: bottom_left, bottom_right, bottom_middle,
    --         top_left, top_right, top_middle
    theme.notification_position = "top_right"

    theme.notification_border_width = dpi(0)
    theme.notification_border_radius = theme.border_radius
    theme.notification_border_color = x.color10

    theme.notification_bg = x.background
    -- theme.notification_bg = x.color8
    theme.notification_fg = x.foreground
    theme.notification_crit_bg = x.background
    theme.notification_crit_fg = x.color1

    theme.notification_icon_size = dpi(60)
    -- theme.notification_height = dpi(80)
    -- theme.notification_width = dpi(300)

    theme.notification_margin = dpi(16)
    theme.notification_opacity = 1
    theme.notification_font = "sans 11"
    
    theme.notification_padding = theme.screen_margin * 2
    theme.notification_spacing = theme.screen_margin * 4
end

return init