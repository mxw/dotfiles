" Vim ftplugin file
" Language:     SuperCollider
" Maintainer:   Max Wang <mxawng@gmail.com>
" URL:          https://github.com/mxw/dotfiles

" Define mappings closer to SCIDE.
let maplocalleader=','

nnoremap <LocalLeader>o :SCNvimStart<CR>
nnoremap <LocalLeader>b :call scnvim#sclang#send("s.boot")<CR>
nnoremap <LocalLeader>k :SCNvimStop<CR>

nmap <LocalLeader>' <Plug>(scnvim-send-line)
imap <C-'>     <C-o><Plug>(scnvim-send-line)
nmap <LocalLeader><CR> <Plug>(scnvim-send-block)
imap <C-,>        <C-o><Plug>(scnvim-send-block)
vmap <LocalLeader><CR> <Plug>(scnvim-send-selection)

nmap <LocalLeader>. <Plug>(scnvim-hard-stop)
imap <C-.>     <C-o><Plug>(scnvim-hard-stop)

nmap <LocalLeader>\     <Plug>(scnvim-postwindow-toggle)
nmap <LocalLeader><C-l> <Plug>(scnvim-postwindow-clear)
