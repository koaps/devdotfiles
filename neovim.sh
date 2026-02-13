#!/bin/bash

DOTDIR=$(pwd)

pip3 install typed-ast --upgrade

if [ "$(uname -s)" == 'Darwin' ]; then
  brew install fd \
    font-mononoki-nerd-font font-hack-nerd-font \
    fzf \
    go \
    lazygit \
    luarocks \
    neovim \
    ripgrep \
else
  sudo apt install -y \
    fonts-mononoki \
    fzf \
    golang \
    lazygit \
    luarocks \
    neovim \
    ripgrep
fi

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=$HOME/.config}
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -sf $DOTDIR/nvim $XDG_CONFIG_HOME/nvim

nvim foo +qa

pyenv virtualenv 3.14.2 neovim
pyenv shell neovim
pip install pynvim pyright ruff
