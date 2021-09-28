#! /bin/sh

export $(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)

# first import environment variables from the login manager
systemctl --user import-environment
# then start the service
exec systemctl --wait --user start sway.service
