local awful = require("awful")
local hotkeysPopup = require("awful.hotkeys_popup").widget
local gears = require("gears")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local apps = require("configuration.apps")
local altKey = require("configuration.keybindings.mod").altKey
local modKey = require("configuration.keybindings.mod").modKey
local numOfTags = require("configuration.tags").numOfTags

-- Settings
local brightnessStep = 10
local volumeStep = 2

local keybindings = gears.table.join(
    --* Awesome Key Bindings
    awful.key(
        { modKey }, "p",
        function()
            awful.spawn.with_shell(apps.default.launcher)
        end,
        {
            description = "show launcher",
            group = "awesome"
        }
    ),
    awful.key(
        { modKey }, "r",
        function()
            awful.spawn.with_shell(apps.default.runner)
        end,
        {
            description = "show runner",
            group = "awesome"
        }
    ),

    awful.key(
        { modKey }, "s",
        hotkeysPopup.show_help,
        {
            description="show help",
            group="awesome"
        }
    ),

    awful.key(
        { modKey, "Control" }, "r",
        awesome.restart,
        {
            description = "reload awesome",
            group = "awesome"
        }
    ),

    awful.key(
        { modKey, "Shift" }, "p",
        function()
            awful.spawn.with_shell(apps.default.activeClients)
        end,
        {
            description = "show active clients",
            group = "awesome"
        }
    ),

    awful.key(
        { modKey, "Shift" }, "q",
        awesome.quit,
        {
            description = "quit awesome",
            group = "awesome"
        }
    ),



    --* Client Key Bindings
    awful.key(
        { modKey }, "j",
        function ()
            awful.client.focus.byidx(1)
        end,
        {
            description = "focus next by index",
            group = "client"
        }
    ),
    awful.key(
        { modKey }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {
            description = "focus previous by index",
            group = "client"
        }
    ),

    awful.key(
        { modKey }, "u",
        awful.client.urgent.jumpto,
        {
            description = "jump to urgent client",
            group = "client"
        }
    ),

    awful.key(
        { modKey, "Control" }, "n",
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
        { modKey, "Shift" }, "j",
        function()
            awful.client.swap.byidx(1)
        end,
        {
            description = "swap with next client by index",
            group = "client"
        }
    ),
    awful.key(
        { modKey, "Shift" }, "k",
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
        { }, "XF86MonBrightnessUp",
        function()
            awful.spawn.with_shell("brightnessctl s +" .. brightnessStep .. "%")
        end,
        {
            description = "increase brightness",
            group = "hotkeys"
        }
    ),
    awful.key(
        { }, "XF86MonBrightnessDown",
        function()
            awful.spawn.with_shell("brightnessctl s " .. brightnessStep .. "%-")
        end,
        {
            description = "decrease brightness",
            group = "hotkeys"
        }
    ),

    awful.key(
        { }, "XF86AudioRaiseVolume",
        function()
            awful.spawn.with_shell("amixer -D pulse sset Master " .. volumeStep .."%+")
        end,
        {
            description = "volume up",
            group = "hotkeys"
        }
    ),
    awful.key(
        { }, "XF86AudioLowerVolume",
        function()
            awful.spawn.with_shell("amixer -D pulse sset Master " .. volumeStep .."%-")
        end,
        {
            description = "volume down",
            group = "hotkeys"
        }
    ),
    awful.key(
        { }, "XF86AudioMute",
        function()
            awful.spawn.with_shell("amixer -D pulse set Master 1+ toggle")
        end,
        {
            description = "volume mute",
            group = "hotkeys"
        }
    ),

    -- TODO: Add Playback Media Controls
    


    --* Launcher Key Bindings
    awful.key(
        { modKey }, "b",
        function()
            awful.spawn.with_shell(apps.default.browser)
        end,
        {
            description = "open a browser",
            group = "launcher"
        }
    ),
    
    awful.key(
        { modKey }, "c",
        function()
            awful.spawn.with_shell(apps.default.ide)
        end,
        {
            description = "open a code editor",
            group = "launcher"
        }
    ),

    awful.key(
        { modKey }, "e",
        function()
            awful.spawn.with_shell(apps.default.filemanager)
        end,
        {
            description = "open a file manager",
            group = "launcher"
        }
    ),

    awful.key(
        { modKey }, "Return",
        function()
            awful.spawn.with_shell(apps.default.terminal)
        end,
        {
            description = "open a terminal",
            group = "launcher"
        }
    ),



    --* Layout Key Bindings
    awful.key(
        { modKey }, "space",
        function()
            awful.layout.inc(1)
        end,
        {
            description = "select next",
            group = "layout"
        }
    ),

    awful.key(
        { altKey }, "l",
        function()
            awful.tag.incmwfact(0.05)
        end,
        {
            description = "increase master width factor",
            group = "layout"
        }
    ),
    awful.key(
        { altKey }, "h",
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {
            description = "decrease master width factor",
            group = "layout"
        }
    ),

    awful.key(
        { altKey }, "k",
        function()
            awful.client.incwfact(0.05)
        end,
        {
            description = "increase master height factor",
            group = "layout"
        }
    ),
    awful.key(
        { altKey }, "j",
        function()
            awful.client.incwfact(-0.05)
        end,
        {
            description = "decrease master height factor",
            group = "layout"
        }
    ),

    awful.key(
        { modKey, "Shift" }, "space",
        function()
            awful.layout.inc(-1)
        end,
        {
            description = "select previous",
            group = "layout"
        }
    ),

    awful.key(
        { modKey, "Control" }, "l",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {
            description = "increase the number of columns",
            group = "layout"
        }
    ),
    awful.key(
        { modKey, "Control" }, "h",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {
            description = "decrease the number of columns",
            group = "layout"
        }
    ),

    awful.key(
        { modKey, "Control" }, "j",
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        {
            description = "increase the number of master clients",
            group = "layout"
        }
    ),
    awful.key(
        { modKey, "Control" }, "k",
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
        { }, "Print",
        function()
            awful.spawn.with_shell(apps.default.screenshotDesktop)
        end,
        {
            description = "take a screenshot of the active monitor",
            group = "screenshots"
        }
    ),
    awful.key(
        { modKey }, "Print",
        function()
            awful.spawn.with_shell(apps.default.screenshotWindow)
        end,
        {
            description = "take a screenshot of the active window",
            group = "screenshots"
        }
    ),
    awful.key(
        { modKey, "Shift" }, "s",
        function()
            awful.spawn.with_shell(apps.default.screenshotRegion)
        end,
        {
            description = "mark an area and screenshot it",
            group = "screenshots"
        }
    ),



    --* Screen Key Bindings
    awful.key(
        { modKey }, "l",
        function()
            awful.screen.focus_relative( 1)
        end,
        {
            description = "focus the next screen",
            group = "screen"
        }
    ),
    awful.key(
        { modKey }, "h",
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
        { modKey, "Control" }, "Left",
        awful.tag.viewprev,
        {
            description = "view previous",
            group = "tag"
        }
    ),
    awful.key(
        { modKey, "Control" }, "Right",
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
function getTopRowKeyCode(number)
    return "#" .. number + 9;
end

function getNumPadKeyCode(number)
    if number == 1 then return "#87"
    elseif number == 2 then return "#88"
    elseif number == 3 then return "#89"

    elseif number == 4 then return "#83"
    elseif number == 5 then return "#84"
    elseif number == 6 then return "#85"

    elseif number == 7 then return "#79"
    elseif number == 8 then return "#80"
    elseif number == 9 then return "#81"
    end
end

for i = 1, numOfTags do
    local keys = { getTopRowKeyCode(i), getNumPadKeyCode(i) }

    for _, key in pairs(keys) do
        -- Hack to only show the first & last tags in the shortcut window
        local descrView, descrToggle, descrMove, descrToggleFocus
        if (i == 1 or i == numOfTags) and key == keys[1] then
            descrView =
            {
                description = "view tag #",
                group = "tag"
            }
            descrToggle =
            {
                description = "toggle tag #",
                group = "tag"
            }
            descrMove =
            {
                description = "move focused client to tag #",
                group = "tag"
            }
            descrToggleFocus =
            {
                description = "toggle focused client on tag #",
                group = "tag"
            }
        end

        keybindings = gears.table.join(keybindings,

            -- View tag only.
            awful.key(
                { modKey }, key,
                function()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                        tag:view_only()
                    end
                end,
                descrView
            ),

            -- Toggle tag display.
            awful.key(
                { modKey, "Control" }, key,
                function()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                        awful.tag.viewtoggle(tag)
                    end
                end,
                descrToggle
            ),

            -- Move client to tag.
            awful.key(
                { modKey, "Shift" }, key,
                function()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:move_to_tag(tag)
                        end
                    end
                end,
                descrMove
            ),

            -- Toggle tag on focused client.
            awful.key(
                { modKey, "Control", "Shift" }, key,
                function()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:toggle_tag(tag)
                        end
                    end
                end,
                descrToggleFocus
            )
        )
    end
end

return keybindings