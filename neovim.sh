#!/bin/bash

DOTDIR=$(pwd)

if [ -z "$(which nvim)" ]; then
  wget https://github.com/neovim/neovim/archive/refs/tags/nightly.tar.gz
  tar zxvf nightly.tar.gz
  cd neovim-nightly
  make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.neovim"
  make install
  cd ../; rm -rf *nightly*
fi

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=$HOME/.config}
if [ ! -h $XDG_CONFIG_HOME/nvim ]; then
  mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
  ln -sf $DOTDIR/nvim $XDG_CONFIG_HOME/nvim
fi

echo "A" | $HOME/.neovim/bin/nvim --headless foo +qa

if [ -d $HOME/.venv ]; then
  source $HOME/.venv/bin/activate
  pip install pynvim pyright ruff
fi
