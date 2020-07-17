local dpi = require("beautiful.xresources").apply_dpi

local icons = require("theme.icons.layouts")

local function init(theme)
    -- Tag names
    theme.tagnames =
    {
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "0",
    }

    theme.layout_cornerne = icons.cornerne
    theme.layout_cornernw = icons.cornernw
    theme.layout_cornerse = icons.cornerse
    theme.layout_cornersw = icons.cornersw

    theme.layout_dwindle = icons.dwindle

    theme.layout_fairh = icons.fairh
    theme.layout_fairv = icons.fairv

    theme.layout_floating  = icons.floating

    theme.layout_fullscreen = icons.fullscreen

    theme.layout_magnifier = icons.magnifier

    theme.layout_max = icons.max

    theme.layout_spiral  = icons.spiral

    theme.layout_tile = icons.tile
    theme.layout_tilebottom = icons.tilebottom
    theme.layout_tileleft   = icons.tileleft
    theme.layout_tiletop = icons.tiletop
end

return init