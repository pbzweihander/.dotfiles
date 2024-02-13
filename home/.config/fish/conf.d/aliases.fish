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
abbr -a cdd "cd -"

# lsd or ls
if type -q lsd
    abbr -a l   "lsd --group-dirs first --"
    abbr -a ls  "lsd --group-dirs first --classify --"
    abbr -a la  "lsd --group-dirs first --classify --almost-all --"
    abbr -a ll  "lsd --group-dirs first --classify --long --"
    abbr -a lla "lsd --group-dirs first --classify --long --almost-all --"
    abbr -a lt  "lsd --group-dirs first --classify --tree --"
    abbr -a lta "lsd --group-dirs first --classify --tree --almost-all --"

    # fzf.fish
    set fzf_preview_dir_cmd lsd --color always --icon always --almost-all --oneline --classify
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
    set -g docker podman
    abbr -a docker podman
    abbr -a docker-compose podman-compose
    abbr -a dk "podman"
    abbr -a dc "podman-compose"
else if groups | grep -qw docker
    set -g docker docker
    abbr -a dk "docker"
    abbr -a dc "docker-compose"
    abbr -a ds "docker service"
    abbr -a dst "docker stack"
    abbr -a dsw "docker swarm"
else
    set -g docker "sudo -E docker"
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
        | $docker login \
            --username AWS \
            --password-stdin \
            "$(aws sts get-caller-identity --query Account --output text).dkr.ecr.$(aws configure get region).amazonaws.com"
end

# kubernetes
abbr -a ktx kubectx
abbr -a ktc "kubectx -c"
abbr -a kns kubens

function pdfcrush
    gs \
        -q -dNOPAUSE -dBATCH -dSAFER \
        -sDEVICE=pdfwrite \
        -dCompatibilityLevel=1.4 \
        -dPDFSETTINGS=/default \
        -dEmbedAllFonts=true -dSubsetFonts=true \
        -sOutputFile=compressed.pdf \
        "$1"
end

# aws
abbr -a pap AWS_PROFILE=personal
abbr -a paws "AWS_PROFILE=personal aws"

# terraform
abbr -a tf terraform

# code
abbr -a c. "code ."
