#!/bin/sh -e
scrot /tmp/lock-screen.png
convert /tmp/lock-screen.png -scale 2.5% -scale 4000% /tmp/lock-screen.png
i3lock -e -i /tmp/lock-screen.png -c 000000
sleep 1
