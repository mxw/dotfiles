" neovim init file
" Maintainer:   Max Wang <mxawng@gmail.com>
" URL:          https://github.com/mxw/dotfiles


""""""""""""""""""""""""""""""""""""""""""
" colorscheme
" 
" this whole section is Claude-aided.
""""""""""""""""""""""""""""""""""""""""""

set notermguicolors

" neovim omits some of vim's syntax group links, leading to duller colors.
augroup VimDefaultLinks
  autocmd!
  autocmd ColorScheme * hi! link CurSearch Search
  autocmd ColorScheme * hi! link VertSplitNC VertSplit
  autocmd ColorScheme * hi! link PmenuMatch Pmenu
  autocmd ColorScheme * hi! link PmenuMatchSel PmenuSel
  autocmd ColorScheme * hi! link Popup Pmenu
  autocmd ColorScheme * hi! link PopupBorder Pmenu
  autocmd ColorScheme * hi! link PopupTitle Pmenu
  autocmd ColorScheme * hi! link QuickFixLine Search
  autocmd ColorScheme * hi! link TabPanel TabLine
  autocmd ColorScheme * hi! link TabPanelSel TabLineSel
  autocmd ColorScheme * hi! link TabPanelFill TabLineFill
  autocmd ColorScheme * hi! link PopupSelected PmenuSel
  autocmd ColorScheme * hi! link MessageWindow WarningMsg
  autocmd ColorScheme * hi! link PopupNotification WarningMsg
  autocmd ColorScheme * hi! link String Constant
  autocmd ColorScheme * hi! link Function Identifier
  autocmd ColorScheme * hi! link Operator Statement
  autocmd ColorScheme * hi! link Delimiter Special
  autocmd ColorScheme * hi! link lCursor Cursor
augroup END

" neovim StatusLine highlighting is leaky.
augroup FixStatusLineBase
  autocmd!
  autocmd ColorScheme * hi StatusLine   cterm=NONE gui=NONE
  autocmd ColorScheme * hi StatusLineNC cterm=NONE gui=NONE
augroup END
