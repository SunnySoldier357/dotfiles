local awfulWidgetClienticon = require("awful.widget.clienticon")
local gtk = require("beautiful.gtk")
local themeAssets = require("beautiful.theme_assets")
local dpi = require("beautiful.xresources").apply_dpi
local gearsShape = require("gears.shape")
local wibox = require("wibox")

local layoutIcons = require("theme.icons.layouts")
local wallpapers = require("theme.wallpapers")

-- Helper functions for modifying hex colors:
local hexColorMatch = "[a-fA-F0-9][a-fA-F0-9]"

local function mix(color1, color2, ratio)
    ratio = ratio or 0.5
    local result = "#"
    local channels1 = color1:gmatch(hexColorMatch)
    local channels2 = color2:gmatch(hexColorMatch)

    for _ = 1, 3 do
        local bgNumericValue = math.ceil(
          (tonumber("0x" .. channels1()) * ratio) +
            (tonumber("0x" .. channels2()) * (1 - ratio))
        )
        if bgNumericValue < 0 then bgNumericValue = 0 end
        if bgNumericValue > 255 then bgNumericValue = 255 end

        result = result .. string.format("%02x", bgNumericValue)
    end
    
    return result
end

local theme = {}
theme.gtk = gtk.get_theme_variables()

theme.gtk.bold_font = theme.gtk.font_family .. " Bold " .. theme.gtk.font_size

theme.gtk.button_border_radius = dpi(theme.gtk.button_border_radius or 0)
theme.gtk.button_border_width = dpi(theme.gtk.button_border_width or 1)

theme.gtk.menubar_border_color = mix(
    theme.gtk.menubar_bg_color,
    theme.gtk.menubar_fg_color,
    0.7
)

theme.font = theme.gtk.font_family .. " " .. theme.gtk.font_size

theme.bg_normal = theme.gtk.bg_color
theme.fg_normal = theme.gtk.fg_color

theme.wibar_bg = theme.gtk.menubar_bg_color
theme.wibar_fg = theme.gtk.menubar_fg_color

theme.bg_focus = theme.gtk.selected_bg_color
theme.fg_focus = theme.gtk.selected_fg_color

theme.bg_urgent = theme.gtk.error_bg_color
theme.fg_urgent = theme.gtk.error_fg_color

theme.bg_minimize = mix(theme.wibar_fg, theme.wibar_bg, 0.3)
theme.fg_minimize = mix(theme.wibar_fg, theme.wibar_bg, 0.9)

theme.bg_systray = theme.wibar_bg

theme.border_focus = theme.gtk.wm_border_focused_color
theme.border_marked = theme.gtk.success_color
theme.border_normal = theme.gtk.wm_border_unfocused_color

theme.border_radius = theme.gtk.button_border_radius
theme.border_width = dpi(theme.gtk.button_border_width or 1)

theme.useless_gap = dpi(3)

local roundedRectShape = function(cr, width, height)
    gearsShape.rounded_rect(
        cr, width, height, theme.border_radius
    )
end

theme.tasklist_fg_normal = theme.wibar_fg
theme.tasklist_bg_normal = theme.wibar_bg
theme.tasklist_fg_focus = theme.tasklist_fg_normal
theme.tasklist_bg_focus = theme.tasklist_bg_normal

theme.tasklist_font_focus = theme.gtk.bold_font

theme.tasklist_shape_minimized = roundedRectShape
theme.tasklist_shape_border_color_minimized = mix(
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
                    widget = awfulWidgetClienticon,
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

theme.taglist_shape_container = roundedRectShape
theme.taglist_shape_clip_container = true
theme.taglist_shape_border_width_container = theme.gtk.button_border_width * 2
theme.taglist_shape_border_color_container = theme.gtk.header_button_border_color

theme.taglist_bg_occupied = theme.gtk.header_button_bg_color
theme.taglist_fg_occupied = theme.gtk.header_button_fg_color

theme.taglist_bg_empty = mix(
    theme.gtk.menubar_bg_color,
    theme.gtk.header_button_bg_color,
    0.3
)
theme.taglist_fg_empty = mix(
    theme.gtk.menubar_bg_color,
    theme.gtk.header_button_fg_color
)

-- Variables set for theming the menu:
theme.tooltip_fg = theme.gtk.tooltip_fg_color
theme.tooltip_bg = theme.gtk.tooltip_bg_color

theme.menu_border_width = theme.gtk.button_border_width
theme.menu_border_color = theme.gtk.menubar_border_color
theme.menu_bg_normal = theme.gtk.menubar_bg_color
theme.menu_fg_normal = theme.gtk.menubar_fg_color

theme.menu_height = dpi(24)
theme.menu_width  = dpi(150)
theme.menu_submenu_icon = nil
theme.menu_submenu = "▸ "

theme.wallpaper = wallpapers.default

-- Layout Icons
theme.layout_fairh = layoutIcons.fairhw
theme.layout_fairv = layoutIcons.fairvw
theme.layout_floating  = layoutIcons.floatingw
theme.layout_magnifier = layoutIcons.magnifierw
theme.layout_max = layoutIcons.maxw
theme.layout_fullscreen = layoutIcons.fullscreenw
theme.layout_tilebottom = layoutIcons.tilebottomw
theme.layout_tileleft   = layoutIcons.tileleftw
theme.layout_tile = layoutIcons.tilew
theme.layout_tiletop = layoutIcons.tiletopw
theme.layout_spiral  = layoutIcons.spiralw
theme.layout_dwindle = layoutIcons.dwindlew
theme.layout_cornernw = layoutIcons.cornernww
theme.layout_cornerne = layoutIcons.cornernew
theme.layout_cornersw = layoutIcons.cornersww
theme.layout_cornerse = layoutIcons.cornersew

-- Recolor Layout icons:
theme = themeAssets.recolor_layout(theme, theme.wibar_fg)

-- Generate Awesome icon:
theme.awesome_icon = themeAssets.awesome_icon(
    theme.menu_height, mix(theme.bg_focus, theme.fg_normal), theme.wibar_bg
)

theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = nil

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme