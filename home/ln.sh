#!/bin/sh -x

# common aliases
ln -rsf .sh_aliases ~/.sh_aliases

# bash
ln -rsf .bashrc ~/.bashrc
ln -rsf .bash_aliases ~/.bash_aliases

# zsh
ln -rsf .zshrc ~/.zshrc
ln -rsf .zsh_aliases ~/.zsh_aliases

# vim
ln -rsf .vimrc ~/.vimrc

# tmux
ln -rsf .tmux.conf ~/.tmux.conf

# git
ln -rsf .gitconfig ~/.gitconfig
ln -rsf .gitexclude ~/.gitexclude

# ssh config
mkdir -p ~/.ssh
ln -rsf .ssh/config ~/.ssh/config

#
# config
#

# alacritty
mkdir -p ~/.config/alacritty
ln -rsf .config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# micro
mkdir -p ~/.config/micro
ln -rsf .config/micro/bindings.json ~/.config/micro/bindings.json
ln -rsf .config/micro/settings.json ~/.config/micro/settings.json
