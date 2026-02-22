#!/bin/bash

DOTDIR=$(pwd)

sudo apt install -y \
    fonts-mononoki \
    fzf

if [ -z "$(which nvim)" ]; then
  wget https://github.com/neovim/neovim/archive/refs/tags/nightly.tar.gz
  tar zxvf nightly.tar.gz
  cd neovim-nightly
  make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.neovim"
  make install
  cd ../; sudo rm -rf *nightly*
fi

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=$HOME/.config}
if [ ! -h $XDG_CONFIG_HOME/nvim ]; then
  mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
  ln -sf $DOTDIR/nvim $XDG_CONFIG_HOME/nvim
fi

nvim foo +qa

if [ -d $HOME/.pyenv ]; then
  pyenv virtualenv 3.14.2 neovim
  pyenv shell neovim
  pip install pynvim pyright ruff
fi
