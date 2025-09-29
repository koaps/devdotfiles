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

nvim -u init.lua foobar.py +qa
ln -sf $DOTDIR/init.lua ~/.config/nvim/init.lua
ln -sf $DOTDIR/luaconf ~/.config/nvim/luaconf

ln -sf $DOTDIR/wezterm.lua ~/.wezterm.lua
