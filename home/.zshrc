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
bindkey -v
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

if [ -d ~/.tfenv/bin ]; then
    export PATH="$HOME/.tfenv/bin:$PATH"
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

    export ZSH_PYENV_LAZY_VIRTUALENV="true"
    export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"

    zinit wait lucid light-mode for \
        pbzweihander/truck \
        simnalamburt/cgitc \
        simnalamburt/zsh-expand-all \
        pick".kubectl_aliases" ahmetb/kubectl-aliases \
        voronkovich/gitignore.plugin.zsh \
        src"z.sh" rupa/z \
        as'completion' id-as'git-completion' https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh \
        zsh-users/zsh-history-substring-search \
        has"helm" id-as"helm-completion" as"completion" atclone"helm completion zsh > _helm" atpull"%atclone" run-atpull zdharma/null \
        has"poetry" id-as"poetry-completion" as"completion" atclone"poetry completions zsh > _poetry" atpull"%atclone" run-atpull zdharma/null \
        has"fnm" id-as"fnm-completion" as"completion" atclone"fnm completions --shell zsh > _fnm" atpull"%atclone" run-atpull zdharma/null \
        atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" zdharma/fast-syntax-highlighting \
        atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
        blockf zsh-users/zsh-completions \
        davidparsson/zsh-pyenv-lazy
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

if [ -f ~/.config/broot/launcher/bash/br ]; then
    source ~/.config/broot/launcher/bash/br
fi

if [ $+command[fnm] ]; then
    eval "$(fnm env --use-on-cd)"
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
