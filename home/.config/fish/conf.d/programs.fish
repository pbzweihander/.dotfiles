# local bin
if test -d ~/.local/bin
    fish_add_path $HOME/.local/bin
end

# cargo (rust)
if test -d ~/.cargo/bin
    fish_add_path $HOME/.cargo/bin
end

# npm (node)
if test -d ~/.npm-global/bin
    fish_add_path $HOME/.npm-global/bin
end

# yarn (node)
if test -d ~/.yarn/bin
    fish_add_path $HOME/.yarn/bin
end

# pyenv
if test -d ~/.pyenv
    set -gx PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
    pyenv init - fish | source

    # pyenv-virtualenv
    if test -d ~/.pyenv/plugins/pyenv-virtualenv
        pyenv virtualenv-init - fish | source
    end
end

# go
if type -q go
    set -gx GOPATH (go env GOPATH)
    fish_add_path $GOPATH/bin
end

# mise
if type -q mise
    mise activate fish | source
    mise completion fish | source
end

# navi
if type -q navi
    navi widget fish | source
end

if type -q helm
    helm completion fish | source
end

# zoxide
if type -q zoxide
    zoxide init fish | source
end
