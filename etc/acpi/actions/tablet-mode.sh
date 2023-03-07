#!/bin/sh

# it will get only the first instance of sway
SWAY_PID="$(pgrep "^sway$" | head -n1)"
USER_ID="$(stat -c "%u" "/proc/${SWAY_PID}/")"
USER="$(id -nu "${USER_ID}")"

case "$4" in
  00000001)
    SWAYSOCK="/run/user/${USER_ID}/sway-ipc.${USER_ID}.${SWAY_PID}.sock" su "${USER}" -c "swaymsg input 1386:21125:Wacom_HID_5285_Finger events enabled"
    ;;
  00000000)
    SWAYSOCK="/run/user/${USER_ID}/sway-ipc.${USER_ID}.${SWAY_PID}.sock" su "${USER}" -c "swaymsg input 1386:21125:Wacom_HID_5285_Finger events disabled"
    ;;
esac
