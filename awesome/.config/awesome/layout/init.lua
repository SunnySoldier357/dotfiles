local awful = require("awful")
local hotkeysPopup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local gears = require("gears")
local menubar = require("menubar")
local wibox = require("wibox")

local updateWidget = require("widgets.update")

local apps = require("configuration.apps")
local modKey = require("configuration.keybindings.mod").modKey

-- Set the terminal for applications that require it
menubar.utils.terminal = apps.default.terminal

local awesomeMenu = {
   { "hotkeys", function() hotkeysPopup.show_help(nil, awful.screen.focused()) end },
   { "edit config", apps.default.editor .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

local mainMenu = awful.menu(
    {
        items =
        {
            { "awesome", awesomeMenu, beautiful.awesome_icon },
            { "open terminal", apps.default.terminal }
        }
    })

local launcher = awful.widget.launcher(
    { image = beautiful.awesome_icon, menu = mainMenu })

local textClockWidget = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglistButtons = gears.table.join(
    awful.button(
        { }, 1,
        function(t)
            t:view_only()
        end
    ),

    awful.button(
        { }, 3,
        awful.tag.viewtoggle
    ),

    awful.button(
        { }, 4,
        function(t)
            awful.tag.viewnext(t.screen)
        end
    ),
    awful.button(
        { }, 5,
        function(t)
            awful.tag.viewprev(t.screen)
        end
    ),

    awful.button(
        { modKey }, 1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),

    awful.button(
        { modKey }, 3,
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end
    )
)

local tasklistButtons = gears.table.join(
    awful.button(
        { }, 1,
        function (c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", { raise = true })
            end
        end
    ),

    awful.button(
        { }, 3,
        function()
            awful.menu.client_list({ theme = { width = 250 } })
        end
    ),
    
    awful.button(
        { }, 4,
        function ()
            awful.client.focus.byidx(1)
        end
    ),
    awful.button(
        { }, 5,
        function ()
            awful.client.focus.byidx(-1)
        end
    )
)

local function set_wallpaper(s)
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

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(
    function(s)
        -- Wallpaper
        set_wallpaper(s)

        -- Create a promptbox for each screen
        s.mypromptbox = awful.widget.prompt()

        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        s.mylayoutbox = awful.widget.layoutbox(s)
        s.mylayoutbox:buttons(gears.table.join(
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

        -- Create a taglist widget
        s.mytaglist = awful.widget.taglist
        {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            buttons = taglistButtons
        }

        -- and apply shape to it
        if beautiful.taglist_shape_container then
            local background_shape_wrapper = wibox.container.background(s.mytaglist)
            background_shape_wrapper._do_taglist_update_now =
                s.mytaglist._do_taglist_update_now
            background_shape_wrapper._do_taglist_update = s.mytaglist._do_taglist_update
            background_shape_wrapper.shape = beautiful.taglist_shape_container
            background_shape_wrapper.shape_clip = beautiful.taglist_shape_clip_container
            background_shape_wrapper.shape_border_width =
                beautiful.taglist_shape_border_width_container
            background_shape_wrapper.shape_border_color =
                beautiful.taglist_shape_border_color_container
            s.mytaglist = background_shape_wrapper
        end

        -- Create a tasklist widget
        s.mytasklist = awful.widget.tasklist
        {
            screen  = s,
            filter  = awful.widget.tasklist.filter.currenttags,
            buttons = tasklistButtons,
            widget_template = beautiful.tasklist_widget_template
        }

        -- Create the wibox
        s.mywibox = awful.wibar({ position = "bottom", screen = s })

        -- Add widgets to the wibox
        s.mywibox:setup
        {
            layout = wibox.layout.align.horizontal,
            {
                -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                launcher,
                s.mytaglist,
                s.mypromptbox,
            },
            s.mytasklist, -- Middle widget
            {
                -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                wibox.widget.systray(),
                updateWidget,
                textClockWidget,
                s.mylayoutbox,
            },
        }
    end
)