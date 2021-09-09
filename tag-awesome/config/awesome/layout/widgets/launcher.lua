local awful = require("awful")
local hotkeysPopup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")

local apps = require("configuration.apps")

local awesomeMenu =
{
    {
       "hotkeys",
        function()
            hotkeysPopup.show_help(nil, awful.screen.focused())
        end
    },
    {
        "edit config",
        apps.default.editor .. " " .. awesome.conffile
    },
    {
        "restart",
        awesome.restart
    },
    {
        "quit",
        function()
            awesome.quit(0)
        end
    },
}

local exitMenu =
{
    {
        "shutdown",
        function()
            awful.spawn.with_shell("poweroff")
        end
    },
    {
        "reboot",
        function()
            awful.spawn.with_shell("reboot")
        end
    }
}

local mainMenu = awful.menu(
    {
        items =
        {
            { "awesome", awesomeMenu, beautiful.awesome_icon },
            { "exit", exitMenu },
            { "open terminal", apps.default.terminal }
        }
    }
)

local launcher = awful.widget.launcher(
    {
        image = beautiful.awesome_icon,
        menu = mainMenu
    }
)

return launcher
