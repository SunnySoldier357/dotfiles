local dpi = require("beautiful").xresources.apply_dpi
local filesystem = require("gears.filesystem")

local matColors = require("theme.mat-colors")

local themeDir = filesystem.get_configuration_dir() .. "/theme"
local theme = {}

theme.font = "Roboto medium 10"
theme.icons = themeDir .. "/icons/"

-- Colors Pallets

-- Primary
theme.primary = matColors.indigo
theme.primary.hue_500 = "#003F6B"

-- Accent
theme.accent = matColors.pink

-- Background
theme.background = matColors.blue_grey

theme.background.hue_800 = "#192933"
theme.background.hue_900 = "#121E25"

local awesome_overrides = function(theme)

end
return
{
    theme = theme,
    awesome_overrides = awesome_overrides
}