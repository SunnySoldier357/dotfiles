-- Default configuration from https://xmonad.org/TUTORIAL.html

-- !~~~~~||--------||---------||~~~~~~
-- !~~~~~|| XMONAD || IMPORTS ||~~~~~~
-- !~~~~~||--------||---------||~~~~~~

import XMonad

import qualified XMonad.StackSet as StackSet
import qualified Data.Map as Map

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar

import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.WindowNavigation

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import Data.Maybe
-- import XMonad.Util.Ungrab

-- !~~~~~||--------||------||~~~~~~
-- !~~~~~|| XMONAD || MAIN ||~~~~~~
-- !~~~~~||--------||------||~~~~~~

main :: IO ()
main = xmonad
    . ewmhFullscreen
    . ewmh
    . dynamicEasySBs barSpawner
    $ myConfig

myConfig = def
    {
        modMask = mod4Mask,   -- Rebind Mod to the super key
        layoutHook = myLayoutHook, -- Use custom layouts
        manageHook = myManageHook <+> manageDocks, -- Match on certain windows
        handleEventHook = docksEventHook,
        startupHook = myStartup,
        workspaces = myWorkspaces,
        terminal = appTerminal
    }
    `additionalKeysP` myKeys
    `removeKeysP` disabledKeys

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

configBorderWidth :: Dimension
configBorderWidth = 2 -- Sets border width for windows

windowCount :: X (Maybe String)
windowCount = gets $ Just
    . show
    . length
    . StackSet.integrate'
    . StackSet.stack
    . StackSet.workspace
    . StackSet.current
    . windowset

-- !~~~~~||--------||-----------||~~~~~~
-- !~~~~~|| XMONAD || AUTOSTART ||~~~~~~
-- !~~~~~||--------||-----------||~~~~~~

myStartup :: X ()
myStartup = do
    spawnOnce "numlockx on" -- Enable numlock
    spawnOnce "xbindkeys --file $XDG_CONFIG_HOME/xbindkeys/config &" -- Disable middle click pasting
    spawnOnce "xsetroot -cursor_name left_ptr"
    spawnOnce "/usr/lib/geoclue-2.0/demos/agent" -- Geolocation for redshift
    spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" -- GUI authentication agent

    spawnOnce "autorandr --change && nitrogen --restore"
    spawnOnce "picom --experimental-backends -b"

    spawnOnce "blueman-applet &"
    spawnOnce "nm-applet --sm-disable &"
    spawnOnce "volumeicon &"
    spawnOnce "~/.local/bin/systray.sh"

    spawnOnce "pcmanfm --daemon-mode" -- Start PCManFM as a daemon to automatically mount removable media

-- !~~~~~||--------||---------||~~~~~~
-- !~~~~~|| XMONAD || LAYOUTS ||~~~~~~
-- !~~~~~||--------||---------||~~~~~~

-- Makes setting the spacingRaw simpler to write. The spacingRaw module adds a
-- configurable amount of space around windows.
mySpacing :: Integer -> l a -> ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

tall = renamed [Replace "tall"]
    $ windowNavigation
    $ withBorder configBorderWidth
    $ lessBorders Screen
    $ smartSpacing 4
    $ Tall 1 (3/100) (1/2)

myLayout = tall ||| Mirror tiled ||| Full
    where
        tiled = Tall nmaster delta ratio
        nmaster = 1 -- Default number of windows in the master pane
        ratio = 1 / 2 -- Default proportion of screen occupied by master pane
        delta = 3 / 100 -- Percent of screen to increment by when resizing panes

myLayoutHook = tall ||| Full

-- !~~~~~||--------||------------||~~~~~~
-- !~~~~~|| XMONAD || WORKSPACES ||~~~~~~
-- !~~~~~||--------||------------||~~~~~~

myWorkspaces = [" dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]

-- !~~~~~||--------||-------------||~~~~~~
-- !~~~~~|| XMONAD || KEYBINDINGS ||~~~~~~
-- !~~~~~||--------||-------------||~~~~~~

disabledKeys :: [String]
disabledKeys =
    [
        "M-S-c", -- Close window
        "M-S-<Return>" -- Spawn Terminal
    ]

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

barSpawner :: ScreenId -> IO StatusBarConfig
barSpawner id = pure $ statusBarProp ("xmobar -x " ++ show (toInteger id)) $ pure myXmobarPP -- nothing on the rest of the screens

myManageHook :: ManageHook
myManageHook = composeAll
    [
        className =? "Gimp" --> doFloat,
        isDialog            --> doFloat
    ]

myXmobarPP :: PP
myXmobarPP = def
    {
        ppSep = "<fc=#666666> <fn=1>|</fn> </fc>", -- Separator character
        ppTitle = xmobarColor "#b3afc2" "" . shorten 60, -- Title of active window
        ppTitleSanitize   = xmobarStrip,
        ppCurrent = xmobarColor "#c792ea" "" . wrap "<box type=Bottom width=2 mb=2 color=#c792ea>" "</box>", -- Current workspace
        ppVisible = xmobarColor "#c792ea" "",              -- Visible but not current workspace
        ppHidden = xmobarColor "#82AAFF" "" . wrap "<box type=Top width=2 mt=2 color=#82AAFF>" "</box>", -- Hidden workspaces
        ppHiddenNoWindows = xmobarColor "#82AAFF" "", -- Hidden workspaces (no windows)
        ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!", -- Urgent workspace
        ppOrder = \(ws : l : t : ex) -> [ws, l] ++ ex ++ [t], -- order of things in xmobar
        ppExtras = [windowCount]
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