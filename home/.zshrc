stty stop undef

export GPG_TTY=$(tty)

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

# etc
export KAKOUNE_POSIX_SHELL=/usr/bin/dash
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

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

# paths and programs
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

if (( $+commands[helix] )); then
    export EDITOR=helix
elif (( $+commands[kak] )); then
    export EDITOR=kak
elif (( $+commands[nvim] )); then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

if (( $+commands[go] )); then
    export GOPATH=$(go env GOPATH)
    export PATH="$GOPATH/bin:$PATH"
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
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ -f "${ZINIT_HOME}/zinit.zsh" ]]; then
    source "${ZINIT_HOME}/zinit.zsh"

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

    zinit pack"default+keys" for fzf

    zinit wait lucid for \
        voronkovich/gitignore.plugin.zsh \
        has"pyenv" id-as"pyenv" atclone"pyenv init - --no-rehash zsh > pyenv.zsh" atpull"%atclone" run-atpull pick"pyenv.zsh" nocompile"!" atload"!__zshrc_pyenv_atload" pbzweihander/zinit-null \
        has"pyenv-virtualenv" id-as"pyenv-virtualenv" atclone"pyenv virtualenv-init - zsh > pyenv-virtualenv.zsh" atpull"%atclone" run-atpull pick"pyenv-virtualenv.zsh" nocompile"!" pbzweihander/zinit-null \
        if"[ -f /opt/asdf-vm/asdf.sh ]" id-as"asdf" pick"/opt/asdf-vm/asdf.sh" nocompile pbzweihander/zinit-null \
        has"rtx" id-as"rtx" atclone"rtx activate zsh > rtx.zsh" atpull"%atclone" run-atpull pick"rtx.zsh" nocompile"!" nocompile pbzweihander/zinit-null \
        has"navi" id-as"navi-widget" atclone"navi widget zsh > navi-widget.zsh" atpull"%atclone" run-atpull pick"navi-widget.zsh" nocompile"!" pbzweihander/zinit-null

    # aliases
    zinit wait lucid for \
        pbzweihander/truck \
        atclone"__zshrc_cgitc_patch" atpull"%atclone" run-atpull pick"init.mod.zsh" simnalamburt/cgitc \
        atclone"__zshrc_kubectl_aliases_patch" atpull"%atclone" run-atpull pick".kubectl_aliases_mod" nocompile"!" ahmetb/kubectl-aliases

    # completions
    zinit wait lucid for \
        id-as"git-completion" as"completion" mv"git-completion -> _git" nocompile https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh \
        has"helm" id-as"helm-completion" as"completion" atclone"helm completion zsh > _helm" atpull"%atclone" run-atpull pick "_helm" nocompile"!" pbzweihander/zinit-null \
        has"poetry" id-as"poetry-completion" as"completion" atclone"poetry completions zsh > _poetry" atpull"%atclone" run-atpull pick "_poetry" nocompile"!" pbzweihander/zinit-null \
        has"kubectl" id-as"kubectl-completion" as"completion" atclone"kubectl completion zsh > _kubectl" atpull"%atclone" run-atpull pick"_kubectl" nocompile"!" pbzweihander/zinit-null

    # last group
    zinit wait lucid for \
        atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" zdharma-continuum/fast-syntax-highlighting \
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

# kakoune
function kas {
    session=$(pwd | sha1sum | awk '{print $1}')
    if ! kak -l | grep -w -q "$session"; then
        echo "$config"
        kak -d -s "$session" &!
        sleep 0.1
        kak -p "$session" <<'EOF'
hook global ClientClose .* %{
    nop %sh{
        {
            sleep 0.1
            if [ -z "$kak_client_list" ]; then
                printf kill | kak -p "$kak_session"
            fi
        } &
    }
}
EOF
    fi
    kak -c "$session" $@
}
