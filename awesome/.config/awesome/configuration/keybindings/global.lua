local awful = require("awful")
local hotkeysPopup = require("awful.hotkeys_popup").widget
local gears = require("gears")

local apps = require("configuration.apps")
local altkey = require("configuration.keybindings.mod").altKey
local modkey = require("configuration.keybindings.mod").modKey

-- Settings
local brightnessStep = 10
local volumeStep = 2

local keybindings = gears.table.join(
    --* Awesome Key Bindings
    awful.key(
        {modkey}, "p",
        function()
            awful.spawn(apps.default.launcher)
        end,
        {
            description = "show launcher",
            group = "awesome"
        }
    ),
    awful.key(
        {modkey}, "r",
        function()
            awful.spawn(apps.default.runner)
        end,
        {
            description = "show runner",
            group = "awesome"
        }
    ),

    awful.key(
        {modkey}, "s",
        hotkeysPopup.show_help,
        {
            description="show help",
            group="awesome"
        }
    ),

    awful.key(
        {modkey, "Control"}, "r",
        awesome.restart,
        {
            description = "reload awesome",
            group = "awesome"
        }
    ),

    awful.key(
        {modkey, "Shift"}, "p",
        function()
            awful.spawn(apps.default.activeClients)
        end,
        {
            description = "show active clients",
            group = "awesome"
        }
    ),

    awful.key(
        {modkey, "Shift"}, "q",
        awesome.quit,
        {
            description = "quit awesome",
            group = "awesome"
        }
    ),



    --* Client Key Bindings
    awful.key(
        {modkey}, "j",
        function ()
            awful.client.focus.byidx(1)
        end,
        {
            description = "focus next by index",
            group = "client"
        }
    ),
    awful.key(
        {modkey}, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {
            description = "focus previous by index",
            group = "client"
        }
    ),

    awful.key(
        {modkey}, "u",
        awful.client.urgent.jumpto,
        {
            description = "jump to urgent client",
            group = "client"
        }
    ),

    awful.key(
        {modkey, "Control"}, "n",
        function ()
            local _client = awful.client.restore()
            -- Focus restored client
            if _client then
                _client:emit_signal("request::activate", "key.unminimize",
                    {raise = true})
            end
        end,
        {
            description = "restore minimized",
            group = "client"
        }
    ),

    awful.key(
        {modkey, "Shift"}, "j",
        function()
            awful.client.swap.byidx(1)
        end,
        {
            description = "swap with next client by index",
            group = "client"
        }
    ),
    awful.key(
        {modkey, "Shift"}, "k",
        function()
            awful.client.swap.byidx(-1)
        end,
        {
            description = "swap with previous client by index",
            group = "client"
        }
    ),



    --* Hotkeys Key Bindings
    awful.key(
        {}, "XF86MonBrightnessUp",
        function()
            awful.spawn("brightnessctl s +" .. brightnessStep .. "%")
        end,
        {
            description = "increase brightness",
            group = "hotkeys"
        }
    ),
    awful.key(
        {}, "XF86MonBrightnessDown",
        function()
            awful.spawn("brightnessctl s " .. brightnessStep .. "%-")
        end,
        {
            description = "decrease brightness",
            group = "hotkeys"
        }
    ),

    awful.key(
        {}, "XF86AudioRaiseVolume",
        function()
            awful.spawn("amixer -D pulse sset Master " .. volumeStep .."%+")
        end,
        {
            description = "volume up",
            group = "hotkeys"
        }
    ),
    awful.key(
        {}, "XF86AudioLowerVolume",
        function()
            awful.spawn("amixer -D pulse sset Master " .. volumeStep .."%-")
        end,
        {
            description = "volume down",
            group = "hotkeys"
        }
    ),
    awful.key(
        {}, "XF86AudioMute",
        function()
            awful.spawn("amixer -D pulse set Master 1+ toggle")
        end,
        {
            description = "volume mute",
            group = "hotkeys"
        }
    ),

    -- TODO: Add Playback Media Controls
    


    --* Launcher Key Bindings
    awful.key(
        {modkey}, "b",
        function()
            awful.util.spawn(apps.default.browser)
        end,
        {
            description = "open a browser",
            group = "launcher"
        }
    ),
    
    awful.key(
        {modkey}, "c",
        function()
            awful.util.spawn(apps.default.ide)
        end,
        {
            description = "open a code editor",
            group = "launcher"
        }
    ),

    awful.key(
        {modkey}, "e",
        function()
            awful.util.spawn(apps.default.filemanager)
        end,
        {
            description = "open a file manager",
            group = "launcher"
        }
    ),

    awful.key(
        {modkey}, "Return",
        function()
            awful.spawn(apps.default.terminal)
        end,
        {
            description = "open a terminal",
            group = "launcher"
        }
    ),



    --* Layout Key Bindings
    awful.key(
        {modkey}, "space",
        function()
            awful.layout.inc(1)
        end,
        {
            description = "select next",
            group = "layout"
        }
    ),

    awful.key(
        {altkey}, "l",
        function()
            awful.tag.incmwfact(0.05)
        end,
        {
            description = "increase master width factor",
            group = "layout"
        }
    ),
    awful.key(
        {altkey}, "h",
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {
            description = "decrease master width factor",
            group = "layout"
        }
    ),

    awful.key(
        {altkey}, "k",
        function()
            awful.client.incwfact(0.05)
        end,
        {
            description = "increase master height factor",
            group = "layout"
        }
    ),
    awful.key(
        {altkey}, "j",
        function()
            awful.client.incwfact(-0.05)
        end,
        {
            description = "decrease master height factor",
            group = "layout"
        }
    ),

    awful.key(
        {modkey, "Shift"}, "space",
        function()
            awful.layout.inc(-1)
        end,
        {
            description = "select previous",
            group = "layout"
        }
    ),

    awful.key(
        {modkey, "Control"}, "l",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {
            description = "increase the number of columns",
            group = "layout"
        }
    ),
    awful.key(
        {modkey, "Control"}, "h",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {
            description = "decrease the number of columns",
            group = "layout"
        }
    ),

    awful.key(
        {modkey, "Control"}, "j",
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        {
            description = "increase the number of master clients",
            group = "layout"
        }
    ),
    awful.key(
        {modkey, "Control"}, "k",
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {
            description = "decrease the number of master clients",
            group = "layout"
        }
    ),



    --* Screenshots Key Bindings
    awful.key(
        {}, "Print",
        function()
            awful.util.spawn_with_shell(apps.default.screenshotDesktop)
        end,
        {
            description = "take a screenshot of the active monitor",
            group = "screenshots"
        }
    ),
    awful.key(
        {modkey}, "Print",
        function()
            awful.util.spawn_with_shell(apps.default.screenshotWindow)
        end,
        {
            description = "take a screenshot of the active window",
            group = "screenshots"
        }
    ),
    awful.key(
        {modkey, "Shift"}, "s",
        function()
            awful.util.spawn_with_shell(apps.default.screenshotRegion)
        end,
        {
            description = "mark an area and screenshot it",
            group = "screenshots"
        }
    ),



    --* Screen Key Bindings
    awful.key(
        {modkey}, "l",
        function()
            awful.screen.focus_relative( 1)
        end,
        {
            description = "focus the next screen",
            group = "screen"
        }
    ),
    awful.key(
        {modkey}, "h",
        function()
            awful.screen.focus_relative(-1)
        end,
        {
            description = "focus the previous screen",
            group = "screen"
        }
    ),



    --* Tag Key Bindings
    awful.key(
        {modkey, "Control"}, "Left",
        awful.tag.viewprev,
        {
            description = "view previous",
            group = "tag"
        }
    ),
    awful.key(
        {modkey, "Control"}, "Right",
        awful.tag.viewnext,
        {
            description = "view next",
            group = "tag"
        }
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do

    -- Hack to only show tags 1 and 9 in the shortcut window
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view =
        {
            description = "view tag #",
            group = "tag"
        }
        descr_toggle =
        {
            description = "toggle tag #",
            group = "tag"
        }
        descr_move =
        {
            description = "move focused client to tag #",
            group = "tag"
        }
        descr_toggle_focus =
        {
            description = "toggle focused client on tag #",
            group = "tag"
        }
    end

    keybindings = gears.table.join(
        keybindings,

        -- View tag only.
        awful.key(
            {modkey}, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            descr_view
        ),

        -- Toggle tag display.
        awful.key(
            {modkey, "Control"}, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            descr_toggle
        ),

        -- Move client to tag.
        awful.key(
            {modkey, "Shift"}, "#" .. i + 9,
            function()
                if _G.client.focus then
                    local tag = _G.client.focus.screen.tags[i]
                    if tag then
                        _G.client.focus:move_to_tag(tag)
                    end
                end
            end,
            descr_move
        ),

        -- Toggle tag on focused client.
        awful.key(
            {modkey, "Control", "Shift"}, "#" .. i + 9,
            function()
                if _G.client.focus then
                    local tag = _G.client.focus.screen.tags[i]
                    if tag then
                        _G.client.focus:toggle_tag(tag)
                    end
                end
            end,
            descr_toggle_focus
        )
    )
end

return keybindings