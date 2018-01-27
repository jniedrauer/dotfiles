xrdb -merge ~/.Xresources
xset r rate 150 40
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "Coordinate Transformation Matrix" 2.400000, 0.000000, 0.000000, 0.000000, 2.400000, 0.000000, 0.000000, 0.000000, 1.000000
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "libinput Accel Speed" 0.5
eval $(dbus-launch --sh-syntax)
exec /usr/bin/ssh-agent i3
