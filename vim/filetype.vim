if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.txt  setfiletype text
  au! BufRead,BufNewFile *.phpt setfiletype php
  au! BufRead,BufNewFile *.scss setfiletype scss
  au! BufRead,BufNewFile *.pl   setfiletype prolog
  au! BufRead,BufNewFile profile  setfiletype sh
augroup END
