#!/bin/bash

DOTDIR=~/.dotfiles

ln -sf $DOTDIR/aliases ~/.aliases
ln -sf $DOTDIR/bash_logout ~/.bash_logout
ln -sf $DOTDIR/bash_profile ~/.bash_profile
ln -sf $DOTDIR/bashrc ~/.bashrc
ln -sf $DOTDIR/exports ~/.exports
ln -sf $DOTDIR/extra ~/.extra
ln -sf $DOTDIR/profile ~/.profile
ln -sf $DOTDIR/gitconfig ~/.gitconfig
ln -sf $DOTDIR/gitconfig.local ~/.gitconfig.local

mkdir ~/.config
ln -sf $DOTDIR/nvim ~/.config/nvim
nvim foobar.py +qa

ln -sf $DOTDIR/wezterm.lua ~/.wezterm.lua
