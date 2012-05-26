" indenting
set sw=2

" output format
let g:Tex_DefaultTargetFormat='pdf'

" pdf viewer
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    let g:Tex_ViewRule_pdf='open'
  else
    let g:Tex_ViewRule_pdf='xdg-open'
  endif
endif

" ignore Makefiles
let g:Tex_UseMakefile=0

" disable placeholders
let g:Imap_UsePlaceHolders=0

" disable folding
let g:Tex_Folding=0

" disable going to error
let g:Tex_GotoError=0

" maps
nmap <Esc>e <F5>
imap <Esc>e <F5>
vmap <Esc>e <F5>
