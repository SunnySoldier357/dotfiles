local awful = require("awful")

local icons = require("theme.icons.tags")

tag.connect_signal("request::default_layouts",
    function()
        awful.layout.append_default_layouts({
            -- First layout is the default layout for all tags
            awful.layout.suit.tile,
            awful.layout.suit.tile.bottom,
            awful.layout.suit.max,
            awful.layout.suit.floating
        })
    end
)

local tags =
{
    {
        title = "browser",
        icon = icons.browser,
        layout = awful.layout.layouts[1]
    },
    {
        title = "file",
        icon = icons.folder,
        layout = awful.layout.layouts[1]
    },
    {
        title = "tty",
        icon = icons.temp,
        layout = awful.layout.layouts[1]
    },
    {
        title = "{}",
        icon = icons.code,
        layout = awful.layout.layouts[1]
    },
    {
        title = "lab",
        icon = icons.lab,
        awful.layout.suit.floating
    },
    {
        title = "game",
        icon = icons.game,
        layout = awful.layout.layouts[1]
    },
    {
        title = "social",
        icon = icons.social,
        layout = awful.layout.layouts[1]
    },
    {
        title = "music",
        icon = icons.music,
        layout = awful.layout.suit.max,
    },
    {
        title = "lab",
        icon = icons.lab,
        awful.layout.suit.floating
    },
}

local count = 0;

screen.connect_signal("request::desktop_decoration",
    function(_screen)
        -- Each screen has its own tag table.
        count = 0;
        
        for i, tag in pairs(tags) do
            count = count + 1;

            awful.tag.add(tag.title,
            {
                -- icon = tag.icon,
                -- icon_only = true,
                layout = tag.layout,
                screen = _screen,
                selected = i == 1
            })
        end
    end
)

return
{
    numOfTags = count
}