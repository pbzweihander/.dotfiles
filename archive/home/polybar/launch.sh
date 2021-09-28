#!/usr/bin/env bash
killall -q polybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    echo "---" >> /tmp/polybar.log
    MONITOR=$m polybar --reload main >>/tmp/polybar.$m.log 2>&1 &
  done
else
    polybar --reload main >>/tmp/polybar.log 2>&1 &
fi
