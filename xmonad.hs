import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
  xmproc <- spawnPipe "xmobar /home/helge/.xmobarrc"
  xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                    { ppOutput = hPutStrLn xmproc
                    , ppTitle = xmobarColor "green" "" . shorten 50
                    }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , startupHook = startup
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((0, 0x1008FF11), spawn "amixer set Master 10-")
        , ((0, 0x1008FF13), spawn "amixer set Master 10+")
        ]
        
startup :: X ()
startup = do
  spawn "feh --bg-fill ~/.xmonad/potato_glados.jpg"
  spawn "xsetroot -cursor_name left_ptr"
