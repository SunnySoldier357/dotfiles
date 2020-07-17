local awful = require("awful")

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
        layout = awful.layout.layouts[1]
    },
    {
        title = "file",
        layout = awful.layout.layouts[1]
    },
    {
        title = "tty",
        layout = awful.layout.layouts[1]
    },
    {
        title = "{}",
        layout = awful.layout.layouts[1]
    },
    {
        title = "lab",
        awful.layout.suit.floating
    },
    {
        title = "game",
        layout = awful.layout.layouts[1]
    },
    {
        title = "social",
        layout = awful.layout.layouts[1]
    },
    {
        title = "music",
        layout = awful.layout.suit.max,
    },
    {
        title = "lab",
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