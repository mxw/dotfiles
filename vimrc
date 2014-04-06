" .vimrc file
" Language:     Markdown
" Maintainer:   Max Wang <mxawng@gmail.com>
" URL:          https://github.com/mxw/dotfiles
" Depends:      pathogen, solarized

" Local sourcing.
if filereadable($HOME."/.vimrc.before")
  source $HOME/.vimrc.before
endif

" vim >> vi.
set nocompatible

" Source pathogen.
runtime pathogen/autoload/pathogen.vim

" Call pathogen.
filetype off
call pathogen#infect()

" Set a mapleader.
let mapleader=','


""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""

" Display.
set ruler             " show cursor coordinates
set title             " show filename
set nonumber          " hide line numbers
set showcmd           " show normal mode commands as they are entered
set showmode          " show editing mode in status line
set showmatch         " flash matching delimiters

set nolist            " no metacharacters
set listchars=tab:>-  " but show tabs if we turn it on

" Autocomplete.
set wildmode=longest,list,full
set wildmenu
set wildignore+=*.o,*.pyc,*.aux,*.cmi,*.cmo,*.cmx
set completeopt=menu,menuone,preview

" Search.
set nohlsearch        " don't persist search highlighting
set incsearch         " search with a typeahead
set magic             " use (some) regexp special characters
set ignorecase        " ignore case...
set smartcase         " ...iff all characters are lower case
set infercase         " case-sensitive completion

" Scrolling.
set wrap              " wrap overlong lines
set scrolloff=0       " don't scroll unless necessary
set scrolljump=5      " scroll five lines at a time

" Turn things off.
set nofoldenable      " no folding
set mouse=            " no mouse
set noerrorbells      " no error bells
set vb t_vb=          " no visual bells

" Backspace over everything.
set backspace=indent,eol,start

" Get rid of security holes.
set nomodeline
set modelines=0


""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting and indent
""""""""""""""""""""""""""""""""""""""""""

" Turn on syntax highlighting and enable filetype stuff.
syntax enable
filetype plugin indent on

" Use solarized for color.
set t_Co=16
set background=dark
colorscheme solarized

" Tab and indent.
set autoindent        " carry indent over to new lines
set shiftwidth=2      " two spaces per indent
set tabstop=2         " number of spaces per tab when viewing
set softtabstop=2     " number of spaces per tab when inserting
set expandtab         " sub spaces for tabs
set smarttab          " make tab key obey indent rules specified above
set shiftround        " make > and < round to shiftwidth

" Highlight trailing whitespace.
hi ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * hi ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/


""""""""""""""""""""""""""""""""""""""""""
" Cache and backups
""""""""""""""""""""""""""""""""""""""""""

" Save marks for ' files, registers for " files, and : lines of history.
set viminfo='20,"20,:50

" History and undo caches.
set history=50        " not too much history
set undolevels=1000   " lots of undo!

" Keep backup junk out of cwd.
set directory=~/tmp//,/tmp//,.
set backupdir=~/tmp//,/tmp//,.

" Save cursor position for reopening.
au BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif


""""""""""""""""""""""""""""""""""""""""""
" Buffers and windows
""""""""""""""""""""""""""""""""""""""""""

" Settings.
set hidden            " keep hidden buffers around
set autoread          " automatically re-read modified files
set splitright        " hsplit to the right
set splitbelow        " vsplit to the left
set laststatus=2      " always show a status line

" Window navigation.
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" Buffer navigation.
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>

" Quickfix and preview windows.
nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>zz :pclose<CR>


""""""""""""""""""""""""""""""""""""""""""
" Maps
""""""""""""""""""""""""""""""""""""""""""

" Switch modes more easily.
nnoremap ; :
inoremap jj <Esc>
inoremap kjk <Esc>

" Make Y behave more like other operators.
nnoremap Y y$

" Make Q formatting; replace Ex mode with <leader>q.
noremap  Q gq
nnoremap <leader>q Q

" Replace <C-a> to accommodate screen escape character.
inoremap <C-z> <C-a>
nnoremap <leader>a <C-a>
nnoremap <leader>x <C-x>

" Move by display line rather than file line.
nnoremap j gj
nnoremap k gk

" Jump to matching delimiters more easily.
nnoremap <leader><Tab> %
vnoremap <leader><Tab> %

" Other useful leader maps.
nnoremap <leader>m  :make<CR>
nnoremap <leader>l  <C-l>
nnoremap <leader>v  <C-w>v

" Toggle spellchecking and paste.
nnoremap <leader>s  :setl spell!<CR>:setl spell?<CR>
nnoremap <leader>p  :setl paste!<CR>:setl paste?<CR>
nnoremap <leader>t  :setl list!<CR>:setl list?<CR>

" Remove trailing whitespace.
nnoremap <silent> <leader>w :%s/\s\+$//<CR>:let @/=''<CR>''

" Convert filetype to unix.
nnoremap <leader>ff :e ++ff=dos<CR>:setlocal ff=unix<CR>

" Make <C-Right> and <C-Left> behave as in emacs.
noremap  <ESC>[1;5C <C-Right>
noremap  <ESC>[1;5D <C-Left>
noremap! <ESC>[1;5C <C-Right>
noremap! <ESC>[1;5D <C-Left>

" Command-line pseudo-emacs keybindings.
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <C-Left>
cnoremap <C-f> <C-Right>
cnoremap <C-d> <Delete>
cnoremap <C-k> <C-\>estrpart(getcmdline(), 0, getcmdpos() - 1)<CR>

" Fewer fat fingers.
noremap ZZ <C-z>

" Only cabbrev actual commands (rather than also, say, search terms).
fu! SingleQuote(str)
  return "'" . substitute(copy(a:str), "'", "''", 'g') . "'"
endfu
fu! Cabbrev(key, value)
  exe printf('cabbrev <expr> %s (getcmdtype() == ":" && getcmdpos() <= %d) ? %s : %s',
    \ a:key, 1+len(a:key), SingleQuote(a:value), SingleQuote(a:key))
endfu


""""""""""""""""""""""""""""""""""""""""""
" Tags
""""""""""""""""""""""""""""""""""""""""""

" Search up the directory tree for tags.
set tags=tags;/

" Use cscope along with ctags if it's available.
if has("cscope")
  " Defer to ctags.
  set cscopetagorder=1

  " Use :cstag instead of :tag and friends (<C-]>, etc.).
  set cscopetag

  " Add cscope databases in `pwd` or in $CSCOPE_DB.
  set nocscopeverbose
  if filereadable("cscope.out")
    cs add cscope.out
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
  set cscopeverbose
else
  " Use :tjump behavior for :tag and friends even without cscope.
  call Cabbrev('tag', 'tjump')
  nnoremap <C-]> g<C-]>
  vnoremap <C-]> g<C-]>
  nnoremap <C-W>] <C-W>g<C-]>
endif

command! -nargs=1 -complete=tag Vstag vsp | tag <args>
call Cabbrev('vstag', 'Vstag')


""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""

" Airline - Use powerline glyphs.
let g:airline_powerline_fonts=1

" NERDTree - Toggle buffer.
nnoremap <leader><Space> :NERDTreeToggle<CR><C-w>=

" NERDTree - Quit vim when all other windows have been closed.
au BufEnter *
  \ if (winnr("$") == 1 && exists("b:NERDTreeType") &&
  \ b:NERDTreeType == "primary") |
  \   q |
  \ endif

" Fugitive - Leader mappings.
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gg :Ggrep<Space>
nnoremap <leader>gl :Glog<CR><CR><CR>:copen<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gh :Gbrowse<CR>
nnoremap <leader>gh :Gbrowse<CR>


""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous
""""""""""""""""""""""""""""""""""""""""""

" Use skeletal template files.
au! BufNewFile * silent! 0r ~/.vim/skel/template.%:e

" Set language defaults.
let g:tex_flavor='latex'
let g:sql_type_default='mysql'

" Set maximum line length.
au FileType liquid,markdown,readme,tex,text setl tw=79

" Kill any trailing whitespace on save.
fu! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfu
au FileType c,cabal,cpp,haskell,javascript,ocaml,php,python,ruby,readme,tex,text
  \ au BufWritePre <buffer>
  \ :call <SID>StripTrailingWhitespaces()


""""""""""""""""""""""""""""""""""""""""""
" Vimscript
""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>n :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>


""""""""""""""""""""""""""""""""""""""""""
" Epilogue
""""""""""""""""""""""""""""""""""""""""""

" Local sourcing.
if filereadable($HOME."/.vimrc.after")
  source $HOME/.vimrc.after
endif
