local awful = require("awful")

local icons = require("theme.icons.tags")

local tags =
{
    {
        title = "browser",
        icon = icons.browser
    },
    {
        title = "file",
        icon = icons.folder
    },
    {
        title = "tty",
        icon = icons.temp
    },
    {
        title = "{}",
        icon = icons.code
    },
    {
        title = "lab",
        icon = icons.lab
    },
    {
        title = "game",
        icon = icons.game
    },
    {
        title = "social",
        icon = icons.social
    },
    {
        title = "music",
        icon = icons.music
    }
}

awful.layout.layouts =
{
    -- First layout is the default layout for all tags
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating
}

local count = 0;

awful.screen.connect_for_each_screen(
    function(s)
        -- Each screen has its own tag table.
        count = 0;
        
        for i, tag in pairs(tags) do
            count = count + 1;

            awful.tag.add(tags[i].title,
            {
                -- icon = tag.icon,
                -- icon_only = true,
                layout = awful.layout.layouts[1],
                screen = s,
                selected = i == 1
            })
        end
    end
)

return
{
    numOfTags = count
}