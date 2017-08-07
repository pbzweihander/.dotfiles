# zplug
source ~/.zplug/init.zsh
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zsh-users/zsh-autosuggestions'
zplug 'simnalamburt/cgitc'
zplug 'simnalamburt/shellder', as:theme
if ! zplug check; then
    zplug install
fi
zplug load

stty stop undef

setopt auto_cd histignorealldups sharehistory
zstyle ':completion:*' menu select

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history


# shellder color scheme
export SHELLDER_CONTEXT_BG='white'
export SHELLDER_CONTEXT_FG='black'

export SHELLDER_DIRECTORY_BG='blue'
export SHELLDER_DIRECTORY_FG='black'

export SHELLDER_GIT_CLEAN_BG='green'
export SHELLDER_GIT_CLEAN_FG='black'
export SHELLDER_GIT_DIRTY_BG='yellow'
export SHELLDER_GIT_DIRTY_FG='black'

export SHELLDER_VIRTUALENV_BG='yellow'
export SHELLDER_VIRTUALENV_FG='white'

export SHELLDER_STATUS_BG='black'
export SHELLDER_STATUS_FG='white'

# Theme
export DEFAULT_USER="$USER"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

scphelma() {
    scp -i ~/.ssh/id_rsa.helma "$1" "thomas@helma.pbzweihander.me:$2"
}

scptrude() {
    scp -i ~/.ssh/id_rsa.trude "$1" "thomas@pbzweihander.me:$2"
}

plugins=(git)

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# keybinding
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[6~' forward-word
bindkey '^[[5~' backward-word

