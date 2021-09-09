local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local naughty = require("naughty")

-- Naughty presets
naughty.config.padding = 8
naughty.config.spacing = 8

naughty.config.defaults.border_width = 0
naughty.config.defaults.hover_timeout = nil
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.ontop = true
naughty.config.defaults.position = "bottom_right"
naughty.config.defaults.screen = screen.primary
naughty.config.defaults.shape = gears.shape.rounded_rect
naughty.config.defaults.timeout = 5