if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.phpt setfiletype php
  au! BufRead,BufNewFile *.scss setfiletype scss
augroup END
