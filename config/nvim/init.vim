" neovim init file
" Maintainer:   Max Wang <mxawng@gmail.com>
" URL:          https://github.com/mxw/dotfiles

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

if filereadable($HOME."/.config/nvim/init.before.vim")
  source $HOME/.config/nvim/init.before.vim
endif
source ~/.vimrc


""""""""""""""""""""""""""""""""""""""""""
" nvim-specific settings
""""""""""""""""""""""""""""""""""""""""""

set number  " too many plugins to not do this


""""""""""""""""""""""""""""""""""""""""""
" plugin precursors
""""""""""""""""""""""""""""""""""""""""""

let $PATH = expand('~/.local/bin') . ':' . $PATH

let g:python3_host_prog = expand('~/.venvs/nvim/bin/python3')


""""""""""""""""""""""""""""""""""""""""""
" plugins
""""""""""""""""""""""""""""""""""""""""""

runtime vim-plug/plug.vim

call plug#begin()

Plug 'goerz/jupytext.nvim'
Plug 'mxw/molten-nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'davidgranstrom/scnvim', { 'do': {-> scnvim#install() } }

call plug#end()


""""""""""""""""""""""""""""""""""""""""""
" python & jupyter config
""""""""""""""""""""""""""""""""""""""""""

lua << EOF
require('jupytext').setup({
  format = 'py:percent',
})
EOF

let g:molten_virt_text_output = 1

nnoremap <silent>       <localleader>ri :MoltenInitSysPrefix<CR>
nnoremap <silent><expr> <localleader>r  :MoltenEvaluateOperator<CR>
nnoremap <silent>       <localleader>r. <LocalLeader>rip
nnoremap <silent>       <localleader>rl :MoltenEvaluateLine<CR>
nnoremap <silent>       <localleader>rr :MoltenReevaluateCell<CR>
xnoremap <silent>       <localleader>r  :<C-u>MoltenEvaluateVisual<CR>
nnoremap <silent>       <localleader>rd :MoltenDelete<CR>
nnoremap <silent>       <localleader>ro :MoltenShowOutput<CR>
nnoremap <silent>       <localleader>rh :MoltenHideOutput<CR>


""""""""""""""""""""""""""""""""""""""""""
" other plugin config
""""""""""""""""""""""""""""""""""""""""""

let g:scnvim_no_mappings = 1


""""""""""""""""""""""""""""""""""""""""""
" delegation
""""""""""""""""""""""""""""""""""""""""""

lua require('config')
