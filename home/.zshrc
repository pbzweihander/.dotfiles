[[ -o interactive ]] || return

if [[ -a /proc/version ]] && grep -q Microsoft /proc/version; then
  unsetopt BG_NICE
fi

#
# zplug
#
autoload -U is-at-least
if is-at-least 4.3.9 && [[ -f ~/.zplug/init.zsh ]]; then
    source ~/.zplug/init.zsh

    zplug "zplug/zplug", hook-build: "zplug --self-manage"

    zplug "pbzweihander/truck"
    #zplug "simnalamburt/cgitc"
    zplug "pbzweihander/cgitc", at:fixed-interpolation
    zplug "simnalamburt/zsh-expand-all"

    zplug "zsh-users/zsh-completions"
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-syntax-highlighting"
    zplug "zsh-users/zsh-history-substring-search"
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down

    if is-at-least 5.2.0; then
        zplug "mafredri/zsh-async"
        zplug "sindresorhus/pure", use:pure.zsh, as:theme
    else
        zplug 'plugins/shrink-path', from:oh-my-zsh
        zplug 'simnalamburt/shellder', as:theme
        export DEFAULT_USER="$USER"
    fi

    zplug 'voronkovich/gitignore.plugin.zsh'

    zplug load

    if ! zplug check; then
        zplug install
    fi
else
    PS1='%n@%m:%~%(!.#.$) '
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
if [ -f ~/.sh_aliases ]; then
    source ~/.sh_aliases
fi

if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

# paths
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin"

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
if [ -f ~/.opam/opam-init/init.zsh ]; then
    source ~/.opam/opam-init/init.zsh
fi

if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

if [ -d ~/.pyenv ]; then
    export PATH="/home/thomas/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# keybinding
bindkey '^[[H' beginning-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;3C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;3D' backward-word

# bat
export BAT_THEME="Sublime Snazzy"
export BAT_PAGER="less -RF"

# local settings
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
