local beautiful = require("beautiful")
local configDir = require("gears.filesystem").get_configuration_dir()

local rofiBinDir = "$XDG_CONFIG_HOME/rofi/bin/"

return
{
    default =
    {
        -- List of defaults applications
        browser = "brave",
        browserPrivate = "brave --incognito",
        editor = "xed",
        filemanager = "pcmanfm -n",
        game = "steam",
        ide = "code",
        lock = "betterlockscreen -l dimblur --display 1",
        music = "cantata",
        social = "caprine",
        terminal = "kitty",

        -- Rofi
        -- activeClients = rofiCommand .. " -show window" ..
        --     " -theme " .. configDir .. "configuration/rofi/windows.rasi",
        launcher = rofiBinDir .. "launcher_misc",
        -- runner = rofiCommand .. " -show run" ..
        --     " -theme " .. configDir .. "configuration/rofi/runner.rasi",

        -- Screenshot
        screenshotDesktop = configDir .. "scripts/screenshot -m",
        screenshotRegion = configDir .. "scripts/screenshot -r",
        screenshotWindow = configDir .. "scripts/screenshot -a"
    }
}