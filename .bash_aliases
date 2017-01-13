alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias llh='ls -alhF'
alias python=python3
alias vi=vim
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias pip=pip3
