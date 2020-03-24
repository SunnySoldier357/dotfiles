local beautiful = require("beautiful")
local filesystem = require("gears.filesystem")

-- Make rofi dpi aware (github:jo148)
local with_dpi = beautiful.xresources.apply_dpi
local get_dpi = beautiful.xresources.get_dpi
local rofi_command =
    "env /usr/bin/rofi -dpi " .. get_dpi() ..
    " -width " .. with_dpi(400) ..
    " -show drun -theme " ..
        filesystem.get_configuration_dir() ..
        '/configuration/rofi.rasi -run-command "/bin/bash -c -i \'shopt -s expand_aliases; {cmd}\'"'

return
{
    -- List of defaults applications
    default =
    {
        terminal = "kitty",
        rofi = rofi_command,
        lock = "light-locker",

        screenshotDesktop = filesystem.get_configuration_dir() .. "configuration/utils/screenshot -m",
        screenshotRegion = filesystem.get_configuration_dir() .. "configuration/utils/screenshot -r",
        screenshotWindow = filesystem.get_configuration_dir() .. "configuration/utils/screenshot -a",

        -- Editing these also edits the default program
        -- associated with each tag/workspace
        browser = "brave",
        -- GUI text editor
        editor = "code",
        social = "caprine",
        game = rofi_command,
        files = "dolphin --new-window",
        music = rofi_command
    },

    -- List of apps to start once on start-up
    run_on_start_up =
    {
        "compton --config " .. filesystem.get_configuration_dir() .. "/configuration/compton.conf",
        -- Wifi
        "nm-applet --indicator",
        -- Enable numlock
        "numlockx on",

        -- Add applications that need to be killed between reloads
        -- to avoid multipled instances, inside the awspawn script
        filesystem.get_configuration_dir() .. "/configuration/awspawn" -- Spawn "dirty" apps that can linger between sessions
    }
}