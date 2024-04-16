#!/bin/bash

wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz

sudo mv -r nvim-linux64 /opt/neovim
sudo ln -s /opt/neovim/bin/nvim /usr/local/bin/nvim


