local theme_assets = require("beautiful.theme_assets")
local dpi = require("beautiful.xresources").apply_dpi

local x = require("theme.colors")

local function init(theme)
    --* Widget separator
    theme.separator_text = "|"
    -- theme.separator_text = " :: "
    -- theme.separator_text = " • "
    -- theme.separator_text = " •• "
    theme.separator_fg = x.color8

    --* Wibar(s)
    -- Keep in mind that these settings could be ignored by the bar theme
    theme.wibar_position = "bottom"
    theme.wibar_height = dpi(45)
    theme.wibar_fg = x.background
    theme.wibar_bg = x.foreground
    --theme.wibar_opacity = 0.7
    theme.wibar_border_color = x.color0
    theme.wibar_border_width = dpi(0)
    theme.wibar_border_radius = dpi(0)
    theme.wibar_width = dpi(380)

    theme.prefix_fg = x.color8

    -- There are other variable sets
    -- overriding the default one when
    -- defined, the sets are:
    -- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
    -- tasklist_[bg|fg]_[focus|urgent]
    -- titlebar_[bg|fg]_[normal|focus]
    -- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
    -- mouse_finder_[color|timeout|animate_timeout|radius|factor]
    -- prompt_[fg|bg|fg_cursor|bg_cursor|font]
    -- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
    -- Example:
    -- theme.taglist_bg_focus = "#ff0000"

    --* Tasklist
    theme.tasklist_font = "sans medium 8"
    theme.tasklist_disable_icon = true
    theme.tasklist_plain_task_name = true
    theme.tasklist_bg_focus = x.color0
    theme.tasklist_fg_focus = x.foreground
    theme.tasklist_bg_normal = "#00000000"
    theme.tasklist_fg_normal = x.foreground.."77"
    theme.tasklist_bg_minimize = "#00000000"
    theme.tasklist_fg_minimize = x.color8
    -- theme.tasklist_font_minimized = "sans italic 8"
    theme.tasklist_bg_urgent = x.background
    theme.tasklist_fg_urgent = x.color3
    theme.tasklist_spacing = dpi(0)
    theme.tasklist_align = "center"

    --* Sidebar
    -- (Sidebar items can be customized in sidebar.lua)
    theme.sidebar_bg = x.background
    theme.sidebar_fg = x.color7
    theme.sidebar_opacity = 1
    theme.sidebar_position = "left" -- left or right
    theme.sidebar_width = dpi(300)
    theme.sidebar_x = 0
    theme.sidebar_y = 0
    theme.sidebar_border_radius = dpi(40)
    -- theme.sidebar_border_radius = theme.border_radius

    --* Dashboard
    theme.dashboard_bg = x.color0.."CC"
    theme.dashboard_fg = x.color7

    --* Exit screen
    theme.exit_screen_bg = x.color0 .. "CC"
    theme.exit_screen_fg = x.color7
    theme.exit_screen_font = "sans 20"
    theme.exit_screen_icon_size = dpi(180)

    --* Lock screen
    theme.lock_screen_bg = x.color0.."CC"
    theme.lock_screen_fg = x.color7

    --* Icon taglist
    local ntags = 10
    theme.taglist_icons_empty = {}
    theme.taglist_icons_occupied = {}
    theme.taglist_icons_focused = {}
    theme.taglist_icons_urgent = {}
    -- table.insert(tag_icons, tag)
    -- for i = 1, ntags do
    --     theme.taglist_icons_empty[i] = taglist_icon_path .. tostring(i) .. "_empty.png"
    --     theme.taglist_icons_occupied[i] = taglist_icon_path .. tostring(i) .. "_occupied.png"
    --     theme.taglist_icons_focused[i] = taglist_icon_path .. tostring(i) .. "_focused.png"
    --     theme.taglist_icons_urgent[i] = taglist_icon_path .. tostring(i) .. "_urgent.png"
    -- end

    --* Noodle Text Taglist
    theme.taglist_text_font = "monospace 25"
    -- theme.taglist_text_font = "sans bold 15"
    theme.taglist_text_empty    = {"","","","","","","","","",""}
    theme.taglist_text_occupied = {"","","","","","","","","",""}
    theme.taglist_text_focused  = {"o","o","o","o","o","o","o","o","o","o"}
    -- theme.taglist_text_focused  = {"","","","","","","","","",""}
    theme.taglist_text_urgent   = {"+","+","+","+","+","+","+","+","+","+"}
    -- theme.taglist_text_urgent   = {"","","","","","","","","",""}
    -- theme.taglist_text_urgent   = {"","","","","","","","","",""}

    theme.taglist_text_color_empty  = { x.background.."22", x.background.."22", x.background.."22", x.background.."22", x.background.."22", x.background.."22", x.background.."22", x.background.."22", x.background.."22", x.background.."22" }
    -- theme.taglist_text_color_occupied  = { x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0" }
    -- theme.taglist_text_color_focused  = { x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0", x.foreground.."F0" }
    -- theme.taglist_text_color_urgent  = { x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground }

    theme.taglist_text_color_occupied  = { x.color1.."99", x.color2.."99", x.color3.."99", x.color4.."99", x.color5.."99", x.color6.."99", x.color1.."99", x.color2.."99", x.color3.."99", x.color4.."99" }
    theme.taglist_text_color_focused  = { x.color9, x.color10, x.color11, x.color12, x.color13, x.color14, x.color9, x.color10, x.color11, x.color12 }
    theme.taglist_text_color_urgent   = { x.background, x.background, x.background, x.background, x.background, x.background, x.background, x.background, x.background, x.background }
    -- theme.taglist_text_color_urgent   = { x.color9, x.color10, x.color11, x.color12, x.color13, x.color14, x.color9, x.color10, x.color11, x.color12 }

    --* Prompt
    theme.prompt_fg = x.color12

    --* Text Taglist (default)
    theme.taglist_font = "monospace bold 9"
    theme.taglist_bg_focus = x.background
    theme.taglist_fg_focus = x.color12
    theme.taglist_bg_occupied = x.background
    theme.taglist_fg_occupied = x.color8
    theme.taglist_bg_empty = x.background
    theme.taglist_fg_empty = x.background
    theme.taglist_bg_urgent = x.background
    theme.taglist_fg_urgent = x.color3
    theme.taglist_disable_icon = true
    theme.taglist_spacing = dpi(0)
    -- Generate taglist squares:
    local taglist_square_size = dpi(0)
    theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
        taglist_square_size, theme.fg_focus
    )
    theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
        taglist_square_size, theme.fg_normal
    )

    --* Variables set for theming the menu:
    theme.menu_height = dpi(35)
    theme.menu_width  = dpi(180)
    theme.menu_bg_normal = x.color0
    theme.menu_fg_normal= x.color7
    theme.menu_bg_focus = x.color8 .. "55"
    theme.menu_fg_focus= x.color7
    theme.menu_border_width = dpi(0)
    theme.menu_border_color = x.color0

    --* Minimal tasklist widget variables
    theme.minimal_tasklist_visible_clients_color = x.color4
    theme.minimal_tasklist_visible_clients_text = ""
    theme.minimal_tasklist_hidden_clients_color = x.color7
    theme.minimal_tasklist_hidden_clients_text = ""

    --* Mpd song
    theme.mpd_song_title_color = x.color7
    theme.mpd_song_artist_color = x.color7
    theme.mpd_song_paused_color = x.color8

    --* Volume bar
    theme.volume_bar_active_color = x.color5
    theme.volume_bar_active_background_color = x.color0
    theme.volume_bar_muted_color = x.color8
    theme.volume_bar_muted_background_color = x.color0

    --* Temperature bar
    theme.temperature_bar_active_color = x.color1
    theme.temperature_bar_background_color = x.color0

    --* Battery bar
    theme.battery_bar_active_color = x.color6
    theme.battery_bar_background_color = x.color0

    --* CPU bar
    theme.cpu_bar_active_color = x.color2
    theme.cpu_bar_background_color = x.color0

    --* RAM bar
    theme.ram_bar_active_color = x.color4
    theme.ram_bar_background_color = x.color0

    --* Brightness bar
    theme.brightness_bar_active_color = x.color3
    theme.brightness_bar_background_color = x.color0

    --* Generate Awesome icon:
    theme.awesome_icon = theme_assets.awesome_icon(
        theme.menu_height, theme.bg_focus, theme.fg_focus
    )
end

return init