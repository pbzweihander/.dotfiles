abbr -a rm "rm -i"
abbr -a rmf "rm -f"
abbr -a rmr "rm -ir"
abbr -a rmrf "rm -rf"
abbr -a cp "cp -i"
abbr -a cpr "cp -ir"
abbr -a cpf "cp -f"
abbr -a cprf "cp -rf"
abbr -a mv "mv -i"
abbr -a mvf "mv -f"

# color=auto
abbr -a grep "grep --color=auto"
abbr -a fgrep "fgrep --color=auto"
abbr -a egrep "egrep --color=auto"
abbr -a diff "diff --color=auto"

# change directory
abbr -a ccd "cd .."
abbr -a cccd "cd ../.."
abbr -a ccccd "cd ../../.."
abbr -a cdd "cd $OLDPWD"

# lsd or exa or ls
if type -q lsd
    abbr -a l "lsd --group-dirs first --"
    abbr -a ls "lsd -F --group-dirs first --"
    abbr -a la "lsd -aF --group-dirs first --"
    abbr -a ll "lsd -lF --group-dirs first --"
    abbr -a lla "lsd -alF --group-dirs first --"
    abbr -a lt "lsd --tree -F --group-dirs first --"
    abbr -a lta "lsd --tree -aF --group-dirs first --"
else if type -q exa
    abbr -a l "exa --group-directories-first"
    abbr -a ls "exa -F --group-directories-first"
    abbr -a la "exa -aF --group-directories-first"
    abbr -a ll "exa -lgF --group-directories-first"
    abbr -a lla "exa -algF --group-directories-first"
    abbr -a lt "exa -TF --group-directories-first"
    abbr -a lta "exa -TFa --group-directories-first"
else
    abbr -a l "ls --color=auto --group-directories-first"
    abbr -a ls "ls --color=auto --group-directories-first"
    abbr -a la "ls --color=auto --group-directories-first -AF"
    abbr -a ll "ls --color=auto --group-directories-first -lF"
    abbr -a lla "ls --color=auto --group-directories-first -AlF"
    abbr -a lh "ls --color=auto --group-directories-first -AlhF"
end

# neovim or vim
if type -q nvim
    abbr -a nvi nvim
    abbr -a vim nvim
    abbr -a vi nvim

    abbr -a nvis "nvim -S Session.vim"
    abbr -a vis "nvim -S Session.vim"

    abbr -a snvi "sudo -E nvim"
    abbr -a svi "sudo -E nvim"
else if type -q vim
    abbr -a vi vim
    abbr -a vis "vim -S Session.vim"

    abbr -a svi "sudo -E vim"
end

# helix
abbr -a hx "helix"
abbr -a shx "sudo -E helix"

# systemctl
abbr -a sctl "sudo systemctl"
abbr -a usctl "systemctl --user"
abbr -a jctl "sudo journalctl"
abbr -a ujctl "journalctl --user"
abbr -a bctl bluetoothctl

# Docker and Podman
abbr -a pm "podman"
abbr -a pc "podman-compose"

if type -q podman
    abbr -a dk "podman"
    abbr -a dc "podman-compose"
else if groups | grep -qw docker
    abbr -a dk "docker"
    abbr -a dc "docker-compose"
    abbr -a ds "docker service"
    abbr -a dst "docker stack"
    abbr -a dsw "docker swarm"
else
    abbr -a dk "sudo -E docker"
    abbr -a dc "sudo -E docker-compose"
    abbr -a ds "sudo -E docker service"
    abbr -a dst "sudo -E docker stack"
    abbr -a dsw "sudo -E docker swarm"
end

# arch package managers
abbr -a ya yay
abbr -a pcm "sudo pacman"
abbr -a pa paru

# clipboard
if test "$(loginctl show-session $(loginctl | awk '/tty/ {print $1}') -p Type | awk -F= '{print $2}')" = 'wayland'
    abbr -a xc "wl-copy"
    abbr -a xp "wl-paste -t text"
else
    abbr -a xc "xclip -i -selection clipboard"
    abbr -a xp "xclip -o -selection clipboard"
end

# hangul-misstypings
abbr -a ㅊㅇ cd
abbr -a ㅣㄴ ls

# python
abbr -a py python
abbr -a pyvenv "pyenv virtualenv"

# aws ecr
function aws-ecr-login
    aws ecr get-login-password \
        | docker login \
            --username AWS \
            --password-stdin \
            "$(aws sts get-caller-identity --query Account --output text).dkr.ecr.$(aws configure get region).amazonaws.com"
end
