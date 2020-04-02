local beautiful = require("beautiful")
local configDir = require("gears.filesystem").get_configuration_dir()

-- Make rofi dpi aware (github:jo148)
local with_dpi = beautiful.xresources.apply_dpi
local get_dpi = beautiful.xresources.get_dpi
local rofi_command =
    "env /usr/bin/rofi -dpi " .. get_dpi() ..
    " -width " .. with_dpi(800) ..
    " -theme " .. configDir .. '/configuration/rofi.rasi'

return
{
    default =
    {
        -- List of defaults applications
        browser = "brave",
        editor = "kate",
        filemanager = "nemo",
        game = "steam",
        ide = "code",
        lock = "light-locker",
        music = "cantata",
        social = "caprine",
        terminal = "kitty",

        -- Rofi
        activeClients = rofi_command .. " -show window",
        launcher = rofi_command .. " -show drun",
        runner = rofi_command .. " -show run",

        -- Screenshot
        screenshotDesktop = configDir .. "configuration/utils/screenshot -m",
        screenshotRegion = configDir .. "configuration/utils/screenshot -r",
        screenshotWindow = configDir .. "configuration/utils/screenshot -a"
    },

    -- List of apps to start once on start-up
    autostart =
    {
        "picom --config " .. configDir .. "/configuration/picom.conf",
        "nm-applet", -- Wifi
        "numlockx on", -- Enable numlock
        "eval $(gnome-keyring-daemon --start)",

        -- Add applications that need to be killed between reloads
        -- to avoid multipled instances, inside the awspawn script
        configDir .. "/configuration/awspawn" -- Spawn "dirty" apps that can linger between sessions
    }
}