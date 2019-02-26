#!/bin/bash
set -euxo pipefail
cp .vimrc ~/.vimrc
mkdir -p ~/.backups
mkdir -p ~/.vim
mkdir -p ~/.vim/autoload && mkdir -p ~/.vim/bundle
pushd .
cd ~/.vim
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd ~/.vim/bundle
git clone https://github.com/ctrlpvim/ctrlp.vim.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/godlygeek/tabular.git
popd
