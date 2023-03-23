" Vim ftplugin file
" Language:     Swift
" Maintainer:   Max Wang <mxawng@gmail.com>
" URL:          https://github.com/mxw/dotfiles

if executable('xcrun')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'haskell-language-server',
    \ 'cmd': {server_info -> ['haskell-language-server-wrapper', '--lsp']},
    \ 'root_uri': {server_info -> lsp#utils#path_to_uri(
    \   utils#find_nearest_parent_dir(
    \     lsp#utils#get_buffer_path(),
    \     ['.git/']
    \   )
    \ )},
    \ 'allowlist': ['haskell', 'lhaskell', 'cabal'],
    \ })
endif
