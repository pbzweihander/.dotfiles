#!/bin/sh

# it will get only the first instance of sway
SWAY_PID="$(pgrep "^sway$" | head -n1)"
USER_ID="$(stat -c "%u" "/proc/${SWAY_PID}/")"
USER="$(id -nu "${USER_ID}")"

case "$4" in
  00000001)
    SWAYSOCK="/run/user/${USER_ID}/sway-ipc.${USER_ID}.${SWAY_PID}.sock" su "${USER}" -c "swaymsg input 1386:21125:Wacom_HID_5285_Finger events enabled"
    SWAYSOCK="/run/user/${USER_ID}/sway-ipc.${USER_ID}.${SWAY_PID}.sock" su "${USER}" -c "rot8 --sleep 3000 --display eDP-1" &
    ;;
  00000000)
    SWAYSOCK="/run/user/${USER_ID}/sway-ipc.${USER_ID}.${SWAY_PID}.sock" su "${USER}" -c "swaymsg input 1386:21125:Wacom_HID_5285_Finger events disabled"
    killall rot8
    SWAYSOCK="/run/user/${USER_ID}/sway-ipc.${USER_ID}.${SWAY_PID}.sock" su "${USER}" -c "swaymsg output eDP-1 transform 0"
    ;;
esac
