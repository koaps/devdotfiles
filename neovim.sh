#!/bin/bash

DOTDIR=$(pwd)

sudo apt install -y \
    fonts-mononoki \
    fzf \
    luarocks

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=$HOME/.config}
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -sf $DOTDIR/nvim $XDG_CONFIG_HOME/nvim

nvim foo +qa

if [ -d $HOME/.pyenv ]; then
  pyenv virtualenv 3.14.2 neovim
  pyenv shell neovim
  pip install pynvim pyright ruff
fi
