" Vim ftplugin file
" Language:     Swift
" Maintainer:   Max Wang <mxawng@gmail.com>
" URL:          https://github.com/mxw/dotfiles

au! FileType swift setl number
au! BufEnter *.swift setl number

if executable('xcrun')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'sourcekit-lsp',
    \ 'cmd': {server_info -> [
      \ 'xcrun',
      \ 'sourcekit-lsp',
      \ '-Xswiftc',
      \ '-sdk',
      \ '-Xswiftc',
      \ trim(system('xcrun --sdk iphonesimulator --show-sdk-path')),
      \ '-Xswiftc',
      \ '-target',
      \ '-Xswiftc',
      \ join([
        \ 'x86_64-apple-ios',
        \ trim(system('xcrun --sdk iphonesimulator --show-sdk-version')),
        \ '-simulator',
        \], '')
      \ ]},
    \ 'root_uri': {server_info -> lsp#utils#path_to_uri(
    \   utils#find_nearest_parent_dir(
    \     lsp#utils#get_buffer_path(),
    \     ['Package.swift', '.git/']
    \   )
    \ )},
    \ 'allowlist': ['swift'],
    \ })
endif

let s:swift_build_args = join([
  \ '-Xswiftc',
  \ '-sdk',
  \ '-Xswiftc',
  \ trim(system('xcrun --sdk iphonesimulator --show-sdk-path')),
  \ '-Xswiftc',
  \ '-target',
  \ '-Xswiftc',
  \ join([
    \ 'x86_64-apple-ios',
    \ trim(system('xcrun --sdk iphonesimulator --show-sdk-version')),
    \ '-simulator',
    \], '')
  \ ])

if executable('xcrun')
  let &l:makeprg = "xcrun swift build " . s:swift_build_args
elseif executable('swift')
  let &l:makeprg = "swift build " . s:swift_build_args
endif
