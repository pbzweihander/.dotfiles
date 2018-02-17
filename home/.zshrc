#
# zplug
#
if [ -f ~/.zplug/init.zsh ]; then
    source ~/.zplug/init.zsh
    zplug 'zplug/zplug', hook-build: 'zplug --self-manage'
    zplug 'zsh-users/zsh-completions'
    zplug 'zsh-users/zsh-syntax-highlighting'
    zplug 'zsh-users/zsh-autosuggestions'
    zplug 'plugins/shrink-path', from:oh-my-zsh
    zplug 'simnalamburt/cgitc'
    zplug 'simnalamburt/shellder', as:theme
    zplug 'voronkovich/gitignore.plugin.zsh'
    zplug load
else
    PS1='%n@%m:%~%# '
fi

#
# zsh-sensible
#
stty stop undef

setopt auto_cd histignorealldups sharehistory
zstyle ':completion:*' menu select

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

#
# zsh-substring-completion
#
setopt complete_in_word
setopt always_to_end
WORDCHARS=''
zmodload -i zsh/complist

# Substring completion
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#
# zshrc
#

# aliases
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

DEFAULT_USER=thomas # for shellder

# Path
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin"
if [ -d ~/.cargo/bin ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi
if [ -d ~/.npm-global/bin ]; then
    export PATH="$HOME/.npm-global/bin:$PATH"
fi

# keybinding
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# local settings
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
