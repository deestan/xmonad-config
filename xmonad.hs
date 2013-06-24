import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
  xmonad $ defaultConfig
    { manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  layoutHook defaultConfig
    , modMask = mod4Mask -- Rebind Mod to the Windows key
    , XMonad.focusFollowsMouse = False
    , startupHook = startup
    } `additionalKeys`
    [ ((0, 0x1008FF11), spawn "amixer set Master 10-")
    , ((0, 0x1008FF13), spawn "amixer set Master 10+")
    ]
    

startup :: X ()
startup = do
  spawn "xloadimage -onroot -center /home/helge/Pictures/wallpaper/acer_service.png"
  spawn "xsetroot -cursor_name left_ptr"
  spawn "xinput --set-prop \"pointer:HP HP Link-5 micro dongle\" \"Device Accel Constant Deceleration\" 3"
