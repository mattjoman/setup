-- xmonad.hs
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit
import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.DynamicLog


import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- So I can remove borders when in full-screen mode.
import XMonad.Actions.NoBorders
import XMonad.Layout.NoBorders

-- Trying to get workspaces in status bar.
--import XMonad.Hooks.StatusBar
--import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Run
import System.IO
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig



--myModMask      = mod4Mask -- set something comfy
myModMask      = mod1Mask -- set something comfy
myWorkspaces   = ["dev", "web", "3", "4", "5", "6", "7", "8", "9"]
myBorderWidth  = 2
myNormalColor  = "#000000"
myFocusedColor = "#ff0000"
myTerminal = "alacritty"





myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((0, xF86XK_MonBrightnessDown         ), spawn "xbacklight -dec 10")
    , ((0, xF86XK_MonBrightnessUp           ), spawn "xbacklight -inc 10")
    , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%")
    , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%")
    , ((myModMask,               xK_d       ), spawn "dmenu_run -l 10 -nb '#000000' -nf '#ffffff' -sb '#ffffff' -sf '#000000' -fn 'some font'")
    , ((myModMask,               xK_p       ), spawn "pavucontrol")
    , ((myModMask,               xK_b       ), spawn "brave")
    , ((myModMask,               xK_m       ), spawn "psensor")
    , ((myModMask ,              xK_Return  ), spawn myTerminal)
    , ((myModMask,               xK_q       ), kill)
    , ((myModMask,               xK_f       ), sendMessage NextLayout)
    , ((myModMask,               xK_n       ), refresh)
    , ((myModMask,               xK_j       ), windows W.focusDown)
    , ((myModMask,               xK_k       ), windows W.focusUp  )
    , ((myModMask,               xK_space   ), windows W.focusMaster  )
    , ((myModMask .|. shiftMask, xK_space   ), windows W.swapMaster)
    , ((myModMask .|. shiftMask, xK_j       ), windows W.swapDown  )
    , ((myModMask .|. shiftMask, xK_k       ), windows W.swapUp    )
    , ((myModMask .|. shiftMask, xK_h       ), sendMessage Shrink)
    , ((myModMask .|. shiftMask, xK_l       ), sendMessage Expand)
    , ((myModMask,               xK_l       ), spawn "slock"     )
    , ((myModMask,               xK_t       ), withFocused $ windows . W.sink)
    , ((myModMask              , xK_comma   ), sendMessage (IncMasterN 1))
    , ((myModMask              , xK_period  ), sendMessage (IncMasterN (-1)))
    , ((myModMask .|. shiftMask, xK_Tab     ), io (exitWith ExitSuccess))
    , ((myModMask              , xK_Tab     ), spawn "xmonad --recompile; xmonad --restart")
    , ((myModMask .|. shiftMask, xK_b       ), sendMessage ToggleStruts)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. myModMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. myModMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]









main = do
  xmonad =<< statusBar "xmobar" myPP toggleStrutsKey defaultConfig
    { terminal           = myTerminal
    , focusFollowsMouse  = True
    , clickJustFocuses   = False
    , modMask            = myModMask
    , keys               = myKeys
    , workspaces         = myWorkspaces
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormalColor
    , focusedBorderColor = myFocusedColor
    , layoutHook         = myLayout
    }

myPP = xmobarPP { ppOutput          = putStrLn
                --, ppCurrent         = xmobarColor "darkgreen" "" . wrap "[" "]"
                , ppCurrent         = xmobarColor "#00ffff" "" . wrap "|" "|"
                , ppHiddenNoWindows = xmobarColor "#111111" "" . wrap "|" "|"
                , ppHidden          = xmobarColor "#888888" "" . wrap "|" "|"
                , ppLayout          = xmobarColor "darkgreen"  "" . shorten 20 . wrap " " " "
                , ppTitle           = xmobarColor "darkgreen"  "" . shorten 20 . wrap " " " "
                , ppSep             = "<fc=#ffffff><fn=1>|</fn></fc>"
                --, ppWsSep           = "<fc=#000000><fn=1> </fn></fc>"
                , ppUrgent          = xmobarColor "red" "yellow"
                }




myLayout = tiled ||| noBorders Full
    where
        tiled = Tall nmaster delta ratio
        nmaster = 1
        ratio = 1/2
        delta = 3/100




toggleStrutsKey XConfig {XMonad.modMask = mod4Mask} = (mod4Mask .|. shiftMask, xK_b)
