#!/bin/bash

if [ -f ~/.local/bin/nvim ]; then
  ~/.local/bin/nvim +PlugInstall +qall
else
  nvim +PlugInstall +qall
fi
