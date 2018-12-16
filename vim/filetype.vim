" filetype.vim
" Maintainer:   Max Wang <mxawng@gmail.com>
" URL:          https://github.com/mxw/dotfiles

if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.md   setfiletype markdown
  au! BufRead,BufNewFile *.phpt setfiletype php
  au! BufRead,BufNewFile *.scss setfiletype scss
  au! BufRead,BufNewFile *.pl   setfiletype prolog

  au! BufRead,BufNewFile profile  setfiletype sh
  au! BufRead,BufNewFile *.gdb  setfiletype gdb
  au! BufRead,BufNewFile screenrc.*  setfiletype screen
  au! BufRead,BufNewFile .screenrc.* setfiletype screen
augroup END
