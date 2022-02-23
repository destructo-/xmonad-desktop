import XMonad
import System.Exit (exitSuccess)
import Data.Monoid

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab
import XMonad.Util.SpawnOnce

import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
import XMonad.Layout.ShowWName
import XMonad.Layout.Renamed

import XMonad.Hooks.EwmhDesktops

defineWorkspaces = [ " sys ", " web ", " dev ", " ctl ", " ssh ", " 6 " , " 7 ", " msg ", " gms " ]

defineManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
defineManageHook = composeAll 
    [ title =? "Mozilla Firefox" --> doShift ( defineWorkspaces !! 1 )
    , title =? "Code - OSS"      --> doShift ( defineWorkspaces !! 2 )
    , title =? "Chromium"        --> doShift ( defineWorkspaces !! 2 )
    -- , title =? "Slack"           --> doShift ( defineWorkspaces !! 9 )
    ]

additionalHotKeys :: [(String, X ())]
additionalHotKeys = 
    [ ("M-S-<Return>", spawn "st -e tmux")
    , ("M-r",   spawn "slock")
    , ("M-p",   spawn "dmenu_run")
    , ("M-S-r", spawn "xmonad --restart")
    , ("M-S-q", io exitSuccess)

    , ("M-<F1>", spawn "amixer set Master toggle")
    , ("M-<F2>", spawn "amixer -c 0 sset Master 10-")
    , ("M-<F3>", spawn "amixer -c 0 sset Master 10+")
    , ("M-<F4>", spawn "amixer set Capture toggle")

    , ("M-<F12>", spawn "feh --randomize --bg-fill ~/wallpapers/*")
    ]

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar ~/.xmonad/xmobarrc" (pure def)) defToggleStrutsKey
     $ def
    { modMask     = mod4Mask
    , layoutHook  = showWName' showWnameConfiguration $ defineLayout
    , startupHook = defineStartupHook
    , workspaces  = defineWorkspaces
    , manageHook  = defineManageHook
    } `additionalKeysP` additionalHotKeys

defineStartupHook :: X()
defineStartupHook = do
    spawn "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 4 --transparent true --alpha 0 --tint 0x121212 --height 23"
    spawn "setxkbmap -layout us,ru -variant -option grp:alt_shift_toggle,terminate:ctrl_alt_bksp"
    spawn "dunst -conf ~/.config/dunstrc"
    spawnOnce "xsetroot -cursor_name left_ptr"
    spawnOnce "feh --randomize --bg-fill ~/wallpapers/*"
    spawnOnce "amixer set Capture toggle nocap"

showWnameConfiguration :: SWNConfig
showWnameConfiguration = def
    { swn_font     = "xft:FiraCode:bold:size=60"
    , swn_fade     = 1.0
    , swn_bgcolor  = "#262626"
    , swn_color    = "#FFC66D"
    }

tabsConfiguration :: Theme
tabsConfiguration = def 
    { activeColor         = "#262626"
    , inactiveColor       = "#121212"
    , activeBorderColor   = "#262626"
    , inactiveBorderColor = "#121212"
    , activeTextColor     = "#FFC66D"
    , inactiveTextColor   = "#CCCCCC"
    , fontName            = "xft:FiraCode:size=11"
    }

defineTabs = renamed [Replace "TB"] $ tabbedBottom shrinkText tabsConfiguration
defineFull = renamed [Replace "FL"] $ Full

defineLayout = noBorders defineTabs ||| noBorders defineFull
