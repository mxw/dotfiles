"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tex.vim
"
" @author Max Wang
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Indenting.
setl shiftwidth=2

" PDF viewer.
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    let s:tex_viewer='open'
  else
    let s:tex_viewer='xdg-open'
  endif
endif

""""""""""""""""""""""""""""""""""""""""""
" LaTeX-Box
""""""""""""""""""""""""""""""""""""""""""

" Local leader.
let maplocalleader=','

" PDF viewer.
let g:LatexBox_viewer=s:tex_viewer
echo s:tex_viewer

""""""""""""""""""""""""""""""""""""""""""
" Vim-LaTeX
""""""""""""""""""""""""""""""""""""""""""

" Compiler output format.
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf'

" PDF viewer.
let g:Tex_ViewRule_pdf=s:tex_viewer

" Disable all the things!
let g:Tex_UseMakefile=0
let g:Imap_UsePlaceHolders=0
let g:Tex_Folding=0
let g:Tex_GotoError=0

" Easy environments.
nmap <Esc>e <F5>
imap <Esc>e <F5>
vmap <Esc>e <F5>
