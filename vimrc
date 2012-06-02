" editor settings
set nocompatible

" display
set ruler
set title
set showcmd
set showmode
set showmatch

" special buffers
set history=50
set undolevels=1000

" turn off bells
set noerrorbells
set vb t_vb=

" keep junk out of cwd
set directory=~/tmp//,/tmp//,.
set backupdir=~/tmp//,/tmp//,.

" pathogen
filetype off
call pathogen#infect()

" highlighting
syntax enable
filetype plugin indent on

" color
se t_Co=16
set background=dark
colorscheme solarized

" window settings
set splitright
set splitbelow
set hidden

" autocomplete
set wildmode=longest,list,full
set wildmenu

" tab and indent
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab

" search
set nohlsearch
set incsearch
set magic
set smartcase
set ignorecase
set infercase

" scrolling
set scrolloff=5
set scrolljump=5

" ctags
set tags=tags;/
nnoremap <C-]> g<C-]>
vnoremap <C-]> g<C-]>
nnoremap <C-W>] <C-W>g<C-]>
cabbrev tag tjump

" insert
set backspace=indent,eol,start

" maps
let mapleader=','
inoremap jj <Esc>
map <ESC>[1;5C <C-Right>
map <ESC>[1;5D <C-Left>
map! <ESC>[1;5C <C-Right>
map! <ESC>[1;5D <C-Left>
map Y y$

" specific filetypes
autocmd BufNewFile,BufRead *.phpt set ft=php
let g:tex_flavor='latex'

" kill any trailing whitespace on save
autocmd FileType c,cabal,cpp,haskell,javascript,ocaml,php,python,readme,text
  \ autocmd BufWritePre <buffer>
  \ :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" highlight overlong lines
"highlight OverLength ctermbg=magenta ctermfg=gray guibg=#592929
"match OverLength /\%81v.\+/
