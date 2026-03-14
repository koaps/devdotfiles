#!/bin/bash

PYVER=3.14

if [ -z "$(which uv)" ]; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  $HOME/.local/bin/uv python install $PYVER
fi

if [ ! -d "$HOME/.venv" ]; then
  $HOME/.local/bin/uv venv --no-project $HOME/.venv
fi
