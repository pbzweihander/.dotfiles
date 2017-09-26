
#
# Colored Prompt
#

RESET="\[$(tput sgr0)\]"
BOLD="\[$(tput bold)\]"

BLACK="\[$(tput setaf 0)\]"
RED="\[$(tput setaf 1)\]"
GREEN="\[$(tput setaf 2)\]"
YELLOW="\[$(tput setaf 3)\]"
BLUE="\[$(tput setaf 4)\]"
MAGENTA="\[$(tput setaf 5)\]"
CYAN="\[$(tput setaf 6)\]"
WHITE="\[$(tput setaf 7)\]"

export PS1="${GREEN}\\u@\\h${RESET}${BOLD}${WHITE}:${RESET}${CYAN}\\w${RESET}${BOLD}${WHITE}\\$ ${RESET}"

#
# Aliases
#

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
