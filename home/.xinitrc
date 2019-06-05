xmodmap ~/.Xmodmap

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx

#export GTK_IM_MODULE=uim
#export QT_IM_MODULE=uim
#uim-xim &
#export XMODIFIERS=@im=uim

dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

exec i3
