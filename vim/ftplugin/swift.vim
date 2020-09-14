" Vim ftplugin file
" Language:     Swift
" Maintainer:   Max Wang <mxawng@gmail.com>
" URL:          https://github.com/mxw/dotfiles

au! FileType swift setl number
au! BufEnter *.swift setl number

let s:swift_build_args = join([
  \ '-Xswiftc',
  \ '-sdk',
  \ '-Xswiftc',
  \ trim(system('xcrun --sdk iphonesimulator --show-sdk-path')),
  \ '-Xswiftc',
  \ '-target',
  \ '-Xswiftc',
  \ 'x86_64-apple-ios13.7-simulator'
  \ ])

if executable('xcrun')
  let &l:makeprg = "xcrun swift build " . s:swift_build_args
elseif executable('swift')
  let &l:makeprg = "swift build " . s:swift_build_args
endif
