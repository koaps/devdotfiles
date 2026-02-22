#!/bin/bash

PYVER=3.14.2

sudo apt install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

if [ ! -d "$HOME/.pyenv" ]; then
  curl https://pyenv.run | bash
fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

PYTHON_CONFIGURE_OPTS="--disable-ipv6 --enable-optimizations --enable-shared" pyenv install $PYVER

eval "$(pyenv init -)"

pyenv global $PYVER

pip install --upgrade pip

git clone https://github.com/pyenv/pyenv-doctor.git $(pyenv root)/plugins/pyenv-doctor
git clone https://github.com/pyenv/pyenv-update.git $(pyenv root)/plugins/pyenv-update
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-which-ext.git $(pyenv root)/plugins/pyenv-which-ext

eval "$(pyenv virtualenv-init -)"
