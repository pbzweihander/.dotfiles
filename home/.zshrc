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

#
# zinit
#
export PS1='%n@%m:%~%(!.#.$) '
if [[ -f ~/.zinit/bin/zinit.zsh ]]; then
    source ~/.zinit/bin/zinit.zsh

    zinit ice wait
    zinit light jonmosco/kube-ps1
    zinit ice wait'!0' pick"async.zsh" src"pure.zsh"
    zinit light sindresorhus/pure

    zinit ice wait
    zinit light pbzweihander/truck
    zinit ice wait
    zinit light simnalamburt/cgitc
    zinit ice wait
    zinit light simnalamburt/zsh-expand-all
    zinit ice wait pick".kubectl_aliases"
    zinit light ahmetb/kubectl-aliases

    zinit ice wait
    zinit light voronkovich/gitignore.plugin.zsh
    zinit ice wait src"z.sh"
    zinit light rupa/z

    zinit ice wait as'completion' id-as'git-completion'
    zinit snippet https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh
    zinit ice wait blockf atpull'zinit creinstall -q .'
    zinit light zsh-users/zsh-completions
    zinit ice wait atload'_zsh_autosuggest_start'
    zinit light zsh-users/zsh-autosuggestions
    zinit ice wait
    zinit light zsh-users/zsh-history-substring-search
    zinit ice wait atinit'zpcompinit; zpcdreplay'
    zinit light zsh-users/zsh-syntax-highlighting
    zinit light-mode wait has"helm" for \
        id-as"helm-completion" \
        as"completion" \
        atclone"helm completion zsh > _helm" \
        atpull"%atclone" \
        run-atpull \
            zdharma/null
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

# rprompt
autoload -Uz colors && colors

function terraform_prompt() {
    if [ -d .terraform ]; then
        workspace="$(command terraform workspace show 2>/dev/null)"
        echo "${workspace}%{$reset_color%} "
    fi
}

export RPROMPT='$(terraform_prompt)'"%{$fg[blue]%}%(1j.✦%j.) %{$fg[yellow]%}%*%{$reset_color%}"

#
# Plugin Configs
#

# pure
export PURE_GIT_UNTRACKED_DIRTY=0

# zsh-sensible
stty stop undef

# zsh-substring-completion
setopt complete_in_word
setopt always_to_end
export WORDCHARS=''
zmodload -i zsh/complist

zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# kube-ps1
function kube_ps1_or_not {
    if command -v kube_ps1 > /dev/null; then
        kube_ps1
    fi
}
function get_cluster() {
    if [ "$1" = "minikube" ]; then
        echo ''
    elif [[ "$1" == arn:aws:eks:* ]]; then
        echo "$1" | cut -d/ -f2
    else
        echo "$1"
    fi
}

export KUBE_PS1_NS_ENABLE=false
export KUBE_PS1_PREFIX=''
export KUBE_PS1_SYMBOL_ENABLE=false
export KUBE_PS1_SUFFIX=''
export KUBE_PS1_CLUSTER_FUNCTION=get_cluster
export KUBE_PS1_NAMESPACE_FUNCTION=get_namespace

export RPROMPT='$(kube_ps1_or_not) '$RPROMPT

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

if [ -f ~/.config/broot/launcher/bash/br ]; then
    source ~/.config/broot/launcher/bash/br
fi

#
# Etc
#

# local settings
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
