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
bindkey -r '^D'

export KAKOUNE_POSIX_SHELL=/usr/bin/dash

#
# Plugin Configs
#

# zsh-substring-completion
setopt complete_in_word
setopt always_to_end
export WORDCHARS=''
zmodload -i zsh/complist

zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# zsh-history-substring-search
function __zshrc_zsh_history_substring_search_bindkey {
    # lazily config bindkey
    # https://github.com/zsh-users/zsh-syntax-highlighting/issues/411#issuecomment-317077561
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
}

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

if [ -d ~/.pyenv/plugins/pyenv-virtualenv/ ]; then
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

if [ -d ~/.yarn/bin ]; then
    export PATH="$HOME/.yarn/bin:$PATH"
fi

if [ -d ~/.tfenv/bin ]; then
    export PATH="$HOME/.tfenv/bin:$PATH"
fi

if (( $+commands[ruby] )) && (( $+commands[gem] )); then
    export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

if (( $+commands[kak] )); then
    export EDITOR=kak
elif (( $+commands[nvim] )); then
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

    zinit depth=1 light-mode for romkatv/powerlevel10k

    function __zshrc_cgitc_patch {
        sed 's/master/$(git_main_branch)/g' abbreviations > abbreviations.mod
        sed 's/master/$(git_main_branch)/g' abbreviations.zsh > abbreviations.mod.zsh
        sed 's/abbreviations/abbreviations.mod/' init.zsh > init.mod.zsh
    }

    function __zshrc_kubectl_aliases_patch {
        sed 's/alias k\(\w*\)a\(\w\?\)=/alias k\1ap\2=/g' .kubectl_aliases > .kubectl_aliases_mod
    }

    function __zshrc_pyenv_atload {
        eval "$(pyenv init --path zsh)"
        command pyenv rehash >/dev/null &!
    }

    zinit wait lucid for \
        voronkovich/gitignore.plugin.zsh \
        has"pyenv" id-as"pyenv" atclone"pyenv init - --no-rehash zsh > pyenv.zsh" atpull"%atclone" run-atpull pick"pyenv.zsh" nocompile"!" atload"!__zshrc_pyenv_atload" zdharma/null \
        has"fnm" id-as"fnm" atclone"fnm env --use-on-cd --shell zsh > fnm.zsh" atpull"%atclone" run-atpull pick"fnm.zsh" nocompile"!" zdharma/null \
        has"fzf" id-as"fzf" multisrc"(completion|key-bindings).zsh" compile"(completion|key-bindings).zsh" svn https://github.com/junegunn/fzf/trunk/shell

    # aliases
    zinit wait lucid for \
        pbzweihander/truck \
        atclone"__zshrc_cgitc_patch" atpull"%atclone" run-atpull pick"init.mod.zsh" simnalamburt/cgitc \
        atclone"__zshrc_kubectl_aliases_patch" atpull"%atclone" run-atpull pick".kubectl_aliases_mod" nocompile"!" ahmetb/kubectl-aliases

    # completions
    zinit wait lucid for \
        id-as"git-completion" as"completion" mv"git-completion -> _git" nocompile https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh \
        has"helm" id-as"helm-completion" as"completion" atclone"helm completion zsh > _helm" atpull"%atclone" run-atpull zdharma/null \
        has"poetry" id-as"poetry-completion" as"completion" atclone"poetry completions zsh > _poetry" atpull"%atclone" run-atpull zdharma/null \
        has"fnm" id-as"fnm-completion" as"completion" atclone"fnm completions --shell zsh > _fnm" atpull"%atclone" run-atpull zdharma/null

    # last group
    zinit wait lucid for \
        atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" zdharma/fast-syntax-highlighting \
        atload"__zshrc_zsh_history_substring_search_bindkey" zsh-users/zsh-history-substring-search \
        blockf atpull"zinit creinstall -q ." zsh-users/zsh-completions \
        atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
        simnalamburt/zsh-expand-all
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
