local awful = require("awful")
local hotkeysPopup = require("awful.hotkeys_popup").widget

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local helpers = require("helpers")
local apps = require("configuration.apps")
local keys = require("configuration.keybindings.keys")
local numOfTags = require("configuration.tags").numOfTags

-- Settings
local brightnessStep = 10
local volumeStep = 2

--* Awesome Key Bindings
awful.keyboard.append_global_keybindings({
    awful.key(
        { keys.super }, "p",
        function()
            awful.spawn.with_shell(apps.default.launcher)
        end,
        {
            description = "show launcher",
            group = "awesome"
        }
    ),
    awful.key(
        { keys.super }, "r",
        function()
            awful.spawn.with_shell(apps.default.runner)
        end,
        {
            description = "show runner",
            group = "awesome"
        }
    ),

    awful.key(
        { keys.super }, "s",
        hotkeysPopup.show_help,
        {
            description="show help",
            group="awesome"
        }
    ),

    awful.key(
        { keys.super }, "Escape",
        function()
            awful.spawn.with_shell(apps.default.lock)
        end,
        {
            description="lock screen",
            group="awesome"
        }
    ),

    awful.key(
        { keys.super, keys.control }, "r",
        awesome.restart,
        {
            description = "reload awesome",
            group = "awesome"
        }
    ),

    awful.key(
        { keys.super, keys.shift }, "p",
        function()
            awful.spawn.with_shell(apps.default.activeClients)
        end,
        {
            description = "show active clients",
            group = "awesome"
        }
    ),

    awful.key(
        { keys.super, keys.shift }, "q",
        awesome.quit,
        {
            description = "quit awesome",
            group = "awesome"
        }
    ),
})

--* Client Key Bindings
awful.keyboard.append_global_keybindings({
    awful.key(
        { keys.super }, "j",
        function ()
            awful.client.focus.byidx(1)
        end,
        {
            description = "focus next by index",
            group = "client"
        }
    ),
    awful.key(
        { keys.super }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {
            description = "focus previous by index",
            group = "client"
        }
    ),

    awful.key(
        { keys.super }, "u",
        awful.client.urgent.jumpto,
        {
            description = "jump to urgent client",
            group = "client"
        }
    ),

    awful.key(
        { keys.super, keys.control }, "n",
        function ()
            local _client = awful.client.restore()
            -- Focus restored client
            if _client then
                _client:activate { raise = true, context = "key.unminimize" }
            end
        end,
        {
            description = "restore minimized",
            group = "client"
        }
    ),

    awful.key(
        { keys.super, keys.shift }, "j",
        function()
            awful.client.swap.byidx(1)
        end,
        {
            description = "swap with next client by index",
            group = "client"
        }
    ),
    awful.key(
        { keys.super, keys.shift }, "k",
        function()
            awful.client.swap.byidx(-1)
        end,
        {
            description = "swap with previous client by index",
            group = "client"
        }
    ),
})

--* Hotkeys Key Bindings
awful.keyboard.append_global_keybindings({
    awful.key(
        { }, keys.brightness.inc,
        function()
            awful.spawn.with_shell("brightnessctl s +" .. brightnessStep .. "%")
        end,
        {
            description = "increase brightness",
            group = "hotkeys"
        }
    ),
    awful.key(
        { }, keys.brightness.dec,
        function()
            awful.spawn.with_shell("brightnessctl s " .. brightnessStep .. "%-")
        end,
        {
            description = "decrease brightness",
            group = "hotkeys"
        }
    ),

    awful.key(
        { }, keys.volume.inc,
        function()
            helpers.volume_control(volumeStep)
        end,
        {
            description = "volume up",
            group = "hotkeys"
        }
    ),
    awful.key(
        { }, keys.volume.dec,
        function()
            helpers.volume_control(-1 * volumeStep)
        end,
        {
            description = "volume down",
            group = "hotkeys"
        }
    ),
    awful.key(
        { }, keys.volume.mute,
        function()
            awful.spawn.with_shell("amixer -D pulse set Master 1+ toggle")
        end,
        {
            description = "volume mute",
            group = "hotkeys"
        }
    ),

    awful.key(
        { }, keys.audio.toggle,
        function()
            awful.spawn.with_shell("playerctl play-pause || mpc toggle")
        end,
        {
            description = "play / pause",
            group = "hotkeys"
        }
    ),
    awful.key(
        { }, keys.audio.next,
        function()
            awful.spawn.with_shell("playerctl next || mpc next")
        end,
        {
            description = "next song",
            group = "hotkeys"
        }
    ),
    awful.key(
        { }, keys.audio.prev,
        function()
            awful.spawn.with_shell("playerctl previous || mpx prev")
        end,
        {
            description = "previous song",
            group = "hotkeys"
        }
    ),
})

--* Launcher Key Bindings
awful.keyboard.append_global_keybindings({
    awful.key(
        { keys.super }, "b",
        function()
            awful.spawn.with_shell(apps.default.browser)
        end,
        {
            description = "open a browser",
            group = "launcher"
        }
    ),
    awful.key(
        { keys.super, keys.shift }, "b",
        function()
            awful.spawn.with_shell(apps.default.browserPrivate)
        end,
        {
            description = "open a private browser",
            group = "launcher"
        }
    ),
    
    awful.key(
        { keys.super }, "c",
        function()
            awful.spawn.with_shell(apps.default.ide)
        end,
        {
            description = "open a code editor",
            group = "launcher"
        }
    ),

    awful.key(
        { keys.super }, "e",
        function()
            awful.spawn.with_shell(apps.default.filemanager)
        end,
        {
            description = "open a file manager",
            group = "launcher"
        }
    ),

    awful.key(
        { keys.super }, keys.enter,
        function()
            awful.spawn.with_shell(apps.default.terminal)
        end,
        {
            description = "open a terminal",
            group = "launcher"
        }
    ),
})

--* Layout Key Bindings
awful.keyboard.append_global_keybindings({
    awful.key(
        { keys.super }, keys.space,
        function()
            awful.layout.inc(1)
        end,
        {
            description = "select next",
            group = "layout"
        }
    ),

    awful.key(
        { keys.alt }, "l",
        function()
            awful.tag.incmwfact(0.05)
        end,
        {
            description = "increase master width factor",
            group = "layout"
        }
    ),
    awful.key(
        { keys.alt }, "h",
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {
            description = "decrease master width factor",
            group = "layout"
        }
    ),

    awful.key(
        { keys.alt }, "k",
        function()
            awful.client.incwfact(0.05)
        end,
        {
            description = "increase master height factor",
            group = "layout"
        }
    ),
    awful.key(
        { keys.alt }, "j",
        function()
            awful.client.incwfact(-0.05)
        end,
        {
            description = "decrease master height factor",
            group = "layout"
        }
    ),

    awful.key(
        { keys.super, keys.shift }, keys.space,
        function()
            awful.layout.inc(-1)
        end,
        {
            description = "select previous",
            group = "layout"
        }
    ),

    awful.key(
        { keys.super, keys.control }, "l",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {
            description = "increase the number of columns",
            group = "layout"
        }
    ),
    awful.key(
        { keys.super, keys.control }, "h",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {
            description = "decrease the number of columns",
            group = "layout"
        }
    ),

    awful.key(
        { keys.super, keys.control }, "j",
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        {
            description = "increase the number of master clients",
            group = "layout"
        }
    ),
    awful.key(
        { keys.super, keys.control }, "k",
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {
            description = "decrease the number of master clients",
            group = "layout"
        }
    ),

})

--* Screenshots Key Bindings
awful.keyboard.append_global_keybindings({
    awful.key(
        { }, keys.printScr,
        function()
            awful.spawn.with_shell(apps.default.screenshotDesktop)
        end,
        {
            description = "take a screenshot of the active monitor",
            group = "screenshots"
        }
    ),
    awful.key(
        { keys.super }, keys.printScr,
        function()
            awful.spawn.with_shell(apps.default.screenshotWindow)
        end,
        {
            description = "take a screenshot of the active window",
            group = "screenshots"
        }
    ),
    awful.key(
        { keys.super, keys.shift }, "s",
        function()
            awful.spawn.with_shell(apps.default.screenshotRegion)
        end,
        {
            description = "mark an area and screenshot it",
            group = "screenshots"
        }
    ),
})

--* Screen Key Bindings
awful.keyboard.append_global_keybindings({
    awful.key(
        { keys.super }, "l",
        function()
            awful.screen.focus_relative(1)
        end,
        {
            description = "focus the next screen",
            group = "screen"
        }
    ),
    awful.key(
        { keys.super }, "h",
        function()
            awful.screen.focus_relative(-1)
        end,
        {
            description = "focus the previous screen",
            group = "screen"
        }
    ),
})

--* Tag Key Bindings
local function view_tag(index)
    local screen = awful.screen.focused()
    local tag = screen.tags[index]
    if tag then
        tag:view_only()
    end
end

local function toggle_tag(index)
    local screen = awful.screen.focused()
    local tag = screen.tags[index]
    if tag then
        awful.tag.viewtoggle(tag)
    end
end

local function move_client_to_tag(index)
    if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
            client.focus:move_to_tag(tag)
        end
    end
end

local function toggle_client_on_tag(index)
    if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
            client.focus:toggle_tag(tag)
        end
    end
end

awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers = { keys.super },
        keygroup = "numrow",
        description = "only view tag",
        group = "tag",
        on_press = view_tag,
    },
    awful.key {
        modifiers = { keys.super },
        keygroup = "numpad",
        on_press = view_tag,
    },

    awful.key {
        modifiers = { keys.super, keys.control },
        keygroup = "numrow",
        description = "toggle tag",
        group = "tag",
        on_press = toggle_tag,
    },
    awful.key {
        modifiers = { keys.super, keys.control },
        keygroup = "numpad",
        on_press = toggle_tag,
    },

    awful.key(
        { keys.super, keys.control }, "Left",
        awful.tag.viewprev,
        {
            description = "view previous",
            group = "tag"
        }
    ),
    awful.key(
        { keys.super, keys.control }, "Right",
        awful.tag.viewnext,
        {
            description = "view next",
            group = "tag"
        }
    ),

    awful.key {
        modifiers = { keys.super, keys.shift },
        keygroup = "numrow",
        description = "move focused client to tag",
        group = "tag",
        on_press = move_client_to_tag,
    },
    awful.key {
        modifiers = { keys.super, keys.shift },
        keygroup = "numpad",
        on_press = move_client_to_tag,
    },

    awful.key {
        modifiers = { keys.super, keys.control, keys.shift },
        keygroup = "numrow",
        description = "toggle focused client on tag",
        group = "tag",
        on_press = toggle_client_on_tag,
    },
    awful.key {
        modifiers = { keys.super, keys.control, keys.shift },
        keygroup = "numpad",
        on_press = toggle_client_on_tag,
    },
})
