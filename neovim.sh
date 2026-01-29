#!/bin/bash

DOTDIR=$(pwd)

if [ "$(uname -s)" == 'Darwin' ]; then
	brew install fd \
		font-mononoki-nerd-font font-hack-nerd-font \
		fzf \
		go \
		lazygit \
		luarocks \
		neovim \
		pyright \
		ripgrep \
		ruff \
		tree-sitter-cli \
		else
	sudo apt install \
		fonts-mononoki \
		fzf \
		golang \
		lazygit \
		luarocks \
		neovim \
		ripgrep \
		tree-sitter-cli -y
fi

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=$HOME/.config}
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -sf $DOTDIR/nvim $XDG_CONFIG_HOME/nvim

nvim foo +qa
