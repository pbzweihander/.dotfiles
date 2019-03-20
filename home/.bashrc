#
# Colored Prompt
#

RESET="\[\033[0m\]"

PURPLE="\[\033[0;35m\]"
RED="\[\033[0;31m\]"
BLUE="\[\033[0;34m\]"
GRAY="\[\033[1;30m\]"

SHELL_WITH_EXIT_CODE="[ \$? = "0" ] && echo -n '$PURPLE\\$' || echo -n '$RED\\$'"

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo " ${BRANCH}${STAT}"
    else
        echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

export PS1="\n${BLUE}\w${GRAY}\`parse_git_branch\` \u@\h \n${PURPLE}\`$SHELL_WITH_EXIT_CODE\` ${RESET}"

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

if [ -d ~/.yarn/bin ]; then
    export PATH="$HOME/.yarn/bin:$PATH"
fi

if [ -d ~/.nodenv/bin ]; then
    export PATH="$HOME/.nodenv/bin:$PATH"
    eval "$(nodenv init -)"
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

