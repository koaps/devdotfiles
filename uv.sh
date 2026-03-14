#!/bin/bash

PYVER=3.14

if [ -z "$(which uv)" ]; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  uv python install $PYVER
fi

if [ ! -d "$HOME/.venv" ]; then
  uv venv --no-project
fi
