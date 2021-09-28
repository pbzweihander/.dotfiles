scrot -o /tmp/lock-screen.png
convert /tmp/lock-screen.png -scale 2.5% -scale 4000% /tmp/lock-screen.png
killall -SIGUSR1 dunst
i3lock  -ne -i /tmp/lock-screen.png -c 000000
killall -SIGUSR2 dunst
rm -f /tmp/lock-screen.png
