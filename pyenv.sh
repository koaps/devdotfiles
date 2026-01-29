#!/bin/bash

PYVER=3.14.2

brew install pyenv

PYTHON_CONFIGURE_OPTS="--disable-ipv6 --enable-optimizations --enable-shared" pyenv install $PYVER

eval "$(pyenv init -)"

pyenv global $PYVER

pip install --upgrade pip

git clone https://github.com/pyenv/pyenv-doctor.git $(pyenv root)/plugins/pyenv-doctor
git clone https://github.com/pyenv/pyenv-update.git $(pyenv root)/plugins/pyenv-update
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
git clone https://github.com/pyenv/pyenv-which-ext.git $(pyenv root)/plugins/pyenv-which-ext
