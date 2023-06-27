# disable greet message
set -gx fish_greeting

if status --is-login
    # set up environment variables
    export $(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)
else if status is-interactive
    # interactive configs
end
