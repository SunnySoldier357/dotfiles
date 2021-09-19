local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local menubar = require("menubar")
local wibox = require("wibox")

local optimusWidget = require("layout.widgets.optimus")
local updateWidget = require("layout.widgets.update")

local apps = require("configuration.apps")

local launcherWidget = require("layout.widgets.launcher")
local taglistWidget = require("layout.widgets.taglist")
local tasklistWidget = require("layout.widgets.tasklist")
local textClockWidget = require("layout.widgets.textClock")

-- Set the terminal for applications that require it
menubar.utils.terminal = apps.default.terminal

-- Create a wibox for each screen and add it
screen.connect_signal("request::wallpaper",
    function(_screen)
        -- Wallpaper
        if beautiful.wallpaper then
            local wallpaper = beautiful.wallpaper

            -- If wallpaper is a function, call it with the screen
            if type(wallpaper) == "function" then
                wallpaper = wallpaper(_screen)
            end

            gears.wallpaper.maximized(wallpaper, _screen, true)
        end
    end
)

local function setUpRightWidgets(_screen)
    local returnWidget = wibox.layout.fixed.horizontal()
    returnWidget:add(wibox.widget.systray())

    returnWidget:add(awful.widget.only_on_screen(updateWidget, "primary"))
    returnWidget:add(awful.widget.only_on_screen(optimusWidget, "primary"))

    returnWidget:add(textClockWidget(_screen))
    returnWidget:add(_screen.mylayoutbox)

    return returnWidget
end

screen.connect_signal("request::desktop_decoration",
    function(_screen)
        taglistWidget(_screen)
        tasklistWidget(_screen)

        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        _screen.mylayoutbox = awful.widget.layoutbox(_screen)
        _screen.mylayoutbox:buttons(gears.table.join(
            awful.button(
                { }, awful.button.names.LEFT,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                { }, awful.button.names.RIGHT,
                function()
                    awful.layout.inc(-1)
                end
            )
        ))

        -- Create the wibox
        _screen.mywibox = awful.wibar({ position = "top", screen = _screen })

        -- Add widgets to the wibox
        _screen.mywibox.widget =
        {
            layout = wibox.layout.align.horizontal,
            {
                -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                launcherWidget,
                _screen.mytaglist,
            },
            _screen.mytasklist, -- Middle widget
            setUpRightWidgets(_screen) -- Right widgets
        }
    end
)