#!/usr/bin/bash -e
OUTPUTS=$(swaymsg -rt get_outputs | jq -r '.[].name')
for OUTPUT in $OUTPUTS; do
    (
        grim -o "$OUTPUT" "/tmp/lock-screen-${OUTPUT}.png" &&\
        convert \
            "/tmp/lock-screen-${OUTPUT}.png" \
            -scale 2.5% \
            -scale 4000% \
            "/tmp/lock-screen-${OUTPUT}.png"
    ) &
done
wait
for OUTPUT in $OUTPUTS; do
    echo "-i ${OUTPUT}:/tmp/lock-screen-${OUTPUT}.png"
done |\
    xargs swaylock -fc 000000
for OUTPUT in $OUTPUTS; do
    rm -f "/tmp/lock-screen-${OUTPUT}.png"
done
