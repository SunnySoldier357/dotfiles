local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")

local x = require("theme.colors")

local function init(theme)
    --* Font
    theme.font = "monospace 11"

    --* Colors
    theme.bg_dark = x.background
    theme.bg_normal = x.color0
    theme.bg_focus = x.color8
    theme.bg_urgent = x.color8
    theme.bg_minimize = x.color8
    theme.bg_systray = x.background

    theme.fg_normal = x.color8
    theme.fg_focus = x.color4
    theme.fg_urgent = x.color9
    theme.fg_minimize = x.color8

    --* Borders & Gaps
    theme.border_width = dpi(0)
    theme.border_normal = x.background
    theme.border_focus = x.background
    -- Rounded corners
    theme.border_radius = dpi(6)

    theme.useless_gap = dpi(5)
    -- This could be used to manually determine how far away from the
    -- screen edge the bars / notifications should be.
    theme.screen_margin = dpi(5)

    -- Edge snap
    theme.snap_shape = gears.shape.rectangle
    theme.snap_bg = x.foreground
    theme.snap_border_width = dpi(3)
end

return init