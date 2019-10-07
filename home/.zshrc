[[ -o interactive ]] || return

if [[ -a /proc/version ]] && grep -q Microsoft /proc/version; then
  unsetopt BG_NICE
fi

# paths
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:$PATH"

if [ -d ~/.local/bin ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d ~/.cargo/bin ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d ~/.npm-global/bin ]; then
    export PATH="$HOME/.npm-global/bin:$PATH"
fi

if [ -d ~/.poetry ]; then
    export PATH="$HOME/.poetry/bin:$PATH"
fi

if [ -d ~/.pyenv ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
fi

if [ -d ~/.yarn/bin ]; then
    export PATH="$HOME/.yarn/bin:$PATH"
fi

if [ -d ~/.nodenv/bin ]; then
    export PATH="$HOME/.nodenv/bin:$PATH"
fi

if command -v ruby >/dev/null && command -v gem >/dev/null; then
    export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

if command -v nvim >/dev/null; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi
STARSHIP=$(command -v starship)

#
# zplug
#
autoload -U is-at-least
if is-at-least 4.3.9 && [[ -f ~/.zplug/init.zsh ]]; then
    source ~/.zplug/init.zsh

    zplug "zplug/zplug", hook-build: "zplug --self-manage"

    zplug "pbzweihander/truck"
    zplug "pbzweihander/cgitc"
    zplug "simnalamburt/zsh-expand-all"

    zplug "zsh-users/zsh-completions"
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-syntax-highlighting"
    zplug "zsh-users/zsh-history-substring-search"
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down

    if [ "$STARSHIP" = "" ]; then
        export RPROMPT='%*'
        if is-at-least 5.2.0; then
            zplug "mafredri/zsh-async"
            zplug "sindresorhus/pure", use:pure.zsh, as:theme
        else
            zplug "plugins/shrink-path", from:oh-my-zsh
            zplug "simnalamburt/shellder", as:theme
            export DEFAULT_USER="$USER"
        fi
    fi

    zplug "voronkovich/gitignore.plugin.zsh"
    zplug "rupa/z", use:z.sh

    zplug load
else
    PS1='%n@%m:%~%(!.#.$) '
fi

#
# Configs
#

setopt auto_cd histignorealldups sharehistory
zstyle ':completion:*' menu select

export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# keybinding
export KEYTIMEOUT=1
bindkey -M vicmd "^a" beginning-of-line
bindkey -M vicmd "^e" end-of-line
bindkey '^[[H' beginning-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;3C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;3D' backward-word

# aliases
if [ -f ~/.sh_aliases ]; then
    source ~/.sh_aliases
fi

if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

#
# Plugin Configs
#

# zsh-sensible
stty stop undef

# zsh-substring-completion
setopt complete_in_word
setopt always_to_end
export WORDCHARS=''
zmodload -i zsh/complist

zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#
# External programs
#

# sources
if [ -f ~/.opam/opam-init/init.zsh ]; then
    source ~/.opam/opam-init/init.zsh
fi

if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

if command -v pyenv >/dev/null; then
    eval "$(pyenv init -)"

    if command -v pyenv-virtualenv >/dev/null; then
        eval "$(pyenv virtualenv-init -)"
    fi
    if command -v pyenv-virtualenvwrapper >/dev/null; then
        export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
        pyenv virtualenvwrapper
    fi
fi

if command -v nodenv >/dev/null; then
    eval "$(nodenv init -)"
fi

# bat
export BAT_THEME="Sublime Snazzy"
export BAT_PAGER="less -RF"

#
# Etc
#

# local settings
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# starship
if [ "$STARSHIP" != "" ]; then
    eval "$(starship init zsh)"
fi
