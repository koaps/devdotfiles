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

mkdir -p ~/.config/go/telemetry
ln -sf $DOTDIR/go_mode ~/.config/go/telemetry/mode

ln -sf $DOTDIR/wezterm.lua ~/.wezterm.lua
