-- Default configuration from https://xmonad.org/TUTORIAL.html

-- !~~~~~||--------||---------||~~~~~~
-- !~~~~~|| XMONAD || IMPORTS ||~~~~~~
-- !~~~~~||--------||---------||~~~~~~

import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Layout.Magnifier
import XMonad.Layout.Renamed
import XMonad.Layout.ThreeColumns

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab

-- !~~~~~||--------||------||~~~~~~
-- !~~~~~|| XMONAD || MAIN ||~~~~~~
-- !~~~~~||--------||------||~~~~~~

main :: IO ()
main = xmonad
    . ewmhFullscreen
    . ewmh
    . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig

myConfig = def
    {
        modMask = mod4Mask,   -- Rebind Mod to the super key
        layoutHook = myLayout, -- Use custom layouts
        manageHook = myManageHook, -- Match on certain windows
        startupHook = myStartup,
        terminal = appTerminal
    }
    `additionalKeysP` myKeys

-- !~~~~~||--------||-----------||~~~~~~
-- !~~~~~|| XMONAD || VARIABLES ||~~~~~~
-- !~~~~~||--------||-----------||~~~~~~

appBrowser, appBrowserPrivate :: String
appBrowser = "brave"
appBrowserPrivate = "brave --incognito"

appText, appIde :: String
appText = "xed"
appIde = "code"

appFile :: String
appFile = "pcmanfm -n"

appLock :: String
appLock = "betterlockscreen -l dimblur --display 1"

appTerminal :: String
appTerminal = "kitty"

configBrightnessStep :: Int
configBrightnessStep = 10

-- !~~~~~||--------||-------------||~~~~~~
-- !~~~~~|| XMONAD || KEYBINDINGS ||~~~~~~
-- !~~~~~||--------||-------------||~~~~~~

myKeys :: [(String, X ())]
myKeys =
    [
        -- * XMonad Key Bindings
        -- TODO: Customise dmenu
        ("M-<Esc>", spawn appLock), -- lock screen
        ("M-C-r", spawn "xmonad --recompile; xmonad --restart"), -- restart XMonad

        -- * Client Key Bindings
        ("M-q", kill), -- Close focused window


        -- * Hotkeys Key Bindings

        -- Brightness
        ("<XF86MonBrightnessUp>", spawn $ "brightnessctl s +" ++ show configBrightnessStep ++ "%"),
        ("<XF86MonBrightnessDown>", spawn $ "brightnessctl s " ++ show configBrightnessStep ++ "%-"),

        -- Media Controls
        ("<XF86AudioPlay>", spawn "playerctl play-pause || mpc toggle"),
        ("M-<XF86AudioMute>", spawn "playerctl play-pause || mpc toggle"),
        
        ("<XF86AudioNext>", spawn "playerctl next || mpc next"),
        ("M-<XF86AudioRaiseVolume>", spawn "playerctl next || mpc next"),

        ("<XF86AudioPrev>", spawn "playerctl previous || mpc prev"),
        ("M-<XF86AudioLowerVolume>", spawn "playerctl previous || mpc prev"),


        -- * Launcher Key Bindings
        ("M-b", spawn appBrowser),
        ("M-S-b", spawn appBrowserPrivate),

        ("M-c", spawn appIde),

        ("M-e", spawn appFile),

        ("M-<Return>", spawn appTerminal)

        -- ("M-S-=", unGrab *> spawn "scrot -s"),
    ]

myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
    where
        threeCol = renamed [Replace "ThreeCol"]
            $ magnifiercz' 1.3
            $ ThreeColMid nmaster delta ratio
        tiled    = Tall nmaster delta ratio
        nmaster  = 1     -- Default number of windows in the master pane
        ratio    = 1/2   -- Default proportion of screen occupied by master pane
        delta    = 3/100 -- Percent of screen to increment by when resizing panes

myStartup = do
    spawnOnce "numlockx on" -- Enable numlock
    spawnOnce "xbindkeys --file $XDG_CONFIG_HOME/xbindkeys/config &" -- Disable middle click pasting
    spawnOnce "xsetroot -cursor_name left_ptr"
    spawnOnce "/usr/lib/geoclue-2.0/demos/agent" -- Geolocation for redshift
    spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" -- GUI authentication agent

    spawnOnce "autorandr --change && nitrogen --restore"
    spawnOnce "picom --experimental-backends -b"

    spawnOnce "blueman-applet &"
    spawnOnce "nm-applet &"
    spawnOnce "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --transparent true --widthtype request --padding 6 --monitor 1 --alpha 0 --tint 0x282c34 --height 22 &"
    spawnOnce "volumeicon &"

    spawnOnce "pcmanfm --daemon-mode" -- Start PCManFM as a daemon to automatically mount removable media

myManageHook :: ManageHook
myManageHook = composeAll
    [
        className =? "Gimp" --> doFloat,
        isDialog            --> doFloat
    ]

myXmobarPP :: PP
myXmobarPP = def
    {
        ppSep             = magenta " • ",
        ppTitleSanitize   = xmobarStrip,
        ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2,
        ppHidden          = white . wrap " " "",
        ppHiddenNoWindows = lowWhite . wrap " " "",
        ppUrgent          = red . wrap (yellow "!") (yellow "!"),
        ppOrder           = \[ws, l, _, wins] -> [ws, l, wins],
        ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""