#!/usr/bin/bash -e
for OUTPUT in $(swaymsg -rt get_outputs | jq -r .[].name); do \
    grim -o $OUTPUT /tmp/lock-screen-${OUTPUT}.png &&\
    convert \
        /tmp/lock-screen-${OUTPUT}.png \
        -scale 2.5% \
        -scale 4000% \
        /tmp/lock-screen-${OUTPUT}.png &&\
    echo -i ${OUTPUT}:/tmp/lock-screen-${OUTPUT}.png; done |\
    xargs swaylock -fc 000000 &&\
    rm -f /tmp/lock-screen-*.png
