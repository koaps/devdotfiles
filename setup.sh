#!/bin/bash

PYVER=3.14

sudo apt install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git fonts-mononoki fzf \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

if [ -z "$(which uv)" ]; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  uv python install $PYVER
fi

if [ ! -d "$HOME/.venv" ]; then
  uv venv --no-project
fi
