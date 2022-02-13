" neovim init file
" Maintainer:   Max Wang <mxawng@gmail.com>
" URL:          https://github.com/mxw/dotfiles

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""

runtime vim-plug/plug.vim

call plug#begin()

Plug 'davidgranstrom/scnvim', { 'do': {-> scnvim#install() } }

call plug#end()
