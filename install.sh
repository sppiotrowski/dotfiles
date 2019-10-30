#!/usr/bin/env bash
DOTFILES_HOME="/Users/spi/projects/dotfiles"

# brew cask install font-hack-nerd-font # fonts
# brew install ripgrep # grep
# brew install neovim
# install https://github.com/junegunn/vim-plug

NVIM_HOME="$HOME/.config/nvim/"
mkdir -p "$NVIM_HOME"
(cd "$NVIM_HOME" && ln -s "$DOTFILES_HOME/init.vim" init.vim)
