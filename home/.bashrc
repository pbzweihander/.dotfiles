
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

# aliases
if [ -f ~/.sh_aliases ]; then
    source ~/.sh_aliases
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# paths
if [ -d ~/.local/bin ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d ~/.cargo/bin ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d ~/.npm-global/bin ]; then
    export PATH="$HOME/.npm-global/bin:$PATH"
fi

# sources
if [ -f ~/.cgitc/init.bash ]; then
    source ~/.cgitc/init.bash
fi

if [ -f ~/.opam/opam-init/init.sh ]; then
    source ~/.opam/opam-init/init.sh
fi

if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
fi

# local settings
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

