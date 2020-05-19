local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local menubar = require("menubar")
local wibox = require("wibox")

local batteryWidget = require("layout.widgets.battery")
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
local function setWallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

local function setUpRightWidgets(_screen)
    local returnWidget = wibox.layout.fixed.horizontal()
    returnWidget:add(wibox.widget.systray())

    if (screen.primary == _screen) then
        returnWidget:add(batteryWidget)
        returnWidget:add(updateWidget)
        returnWidget:add(optimusWidget)
    end

    returnWidget:add(textClockWidget(_screen))
    returnWidget:add(_screen.mylayoutbox)

    return returnWidget
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", setWallpaper)

awful.screen.connect_for_each_screen(
    function(_screen)
        -- Wallpaper
        setWallpaper(_screen)

        taglistWidget(_screen)
        tasklistWidget(_screen)

        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        _screen.mylayoutbox = awful.widget.layoutbox(_screen)
        _screen.mylayoutbox:buttons(gears.table.join(
            awful.button(
                { }, 1,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                { }, 3,
                function()
                    awful.layout.inc(-1)
                end
            ),
            awful.button(
                { }, 4,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                { }, 5,
                function()
                    awful.layout.inc(-1)
                end
            )
        ))

        -- Create the wibox
        _screen.mywibox = awful.wibar({ position = "bottom", screen = _screen })

        -- Add widgets to the wibox
        _screen.mywibox:setup
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