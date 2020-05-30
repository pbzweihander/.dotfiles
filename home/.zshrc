stty stop undef

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ -o interactive ]] || return

if [[ -a /proc/version ]] && grep -q Microsoft /proc/version; then
  unsetopt BG_NICE
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

#
# Plugin Configs
#

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

# zsh-autosuggestions
typeset -g ZSH_AUTOSUGGEST_USE_ASYNC=1
typeset -g ZSH_AUTOSUGGEST_STRATEGY=(history completion)

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

if [ $+command[ruby] ] && [ $+command[gem] ]; then
    export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

if [ $+command[nvim] ]; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

# aliases
if [ -f ~/.sh_aliases ]; then
    source ~/.sh_aliases
fi

if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

#
# zinit
#
export PS1='%n@%m:%~%(!.#.$) '
if [[ -f ~/.zinit/bin/zinit.zsh ]]; then
    source ~/.zinit/bin/zinit.zsh

    zinit ice depth=1
    zinit light romkatv/powerlevel10k

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
# External programs
#

# sources
if [ -f ~/.opam/opam-init/init.zsh ]; then
    source ~/.opam/opam-init/init.zsh
fi

if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

if [ $+command[pyenv] ]; then
    eval "$(pyenv init -)"

    if [ $+command[pyenv-virtualenv] ]; then
        eval "$(pyenv virtualenv-init -)"
    fi
    if [ $+command[pyenv-virtualenvwrapper] ]; then
        export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
        pyenv virtualenvwrapper_lazy
    fi
fi

if [ $+command[nodenv] ]; then
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
