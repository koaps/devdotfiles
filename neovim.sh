#!/bin/bash

DOTDIR=$(pwd)

if [ -z "$(which nvim)" ]; then
  wget https://github.com/neovim/neovim/archive/refs/tags/nightly.tar.gz
  tar zxvf nightly.tar.gz
  cd neovim-nightly
  make CMAKE_BUILD_TYPE=Release
  sudo make install
  cd ../; sudo rm -rf neovim-nightly
fi

sudo apt install -y \
    fonts-mononoki \
    fzf \
    luarocks

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
