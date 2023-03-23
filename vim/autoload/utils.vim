" Vim autoload file
" Language:     Vimscript
" Maintainer:   Max Wang <mxawng@gmail.com>
" URL:          https://github.com/mxw/dotfiles

function! utils#find_nearest_parent_dir(path, filename) abort
  let l:candidates = map(a:filename, {idx ->
    \ lsp#utils#find_nearest_parent_file_directory(a:path, a:filename[idx])
    \ })
  let l:sorted = sort(l:candidates, {l, r -> strlen(r) - strlen(l)})
  return l:sorted[0]
endfunction
