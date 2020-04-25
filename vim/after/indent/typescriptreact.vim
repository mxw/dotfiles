" Vim indent file
" Language:     TypeScript JSX
" Maintainer:   Max Wang <mxawng@gmail.com>
" URL:          https://github.com/mxw/dotfiles

if exists('b:did_indent')
  let s:did_indent=b:did_indent
  unlet b:did_indent
endif
exe 'runtime! indent/typescript.vim'
if exists('s:did_indent')
  let b:did_indent=s:did_indent
endif

setl indentexpr=GetTypescriptIndent()
