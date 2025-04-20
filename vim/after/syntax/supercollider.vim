" Vim syntax file
" Language:     SuperCollider
" Maintainer:   Max Wang <mxawng@gmail.com>
" URL:          https://github.com/mxw/dotfiles

syn clear scInfinity
syn clear scBinaryoperator
syn clear scCommentTodo
syn clear scLineComment
syn clear scComment

syn match scInfinity "\W\@<=inf\W\@="

syn keyword scBinaryoperator min max round trunc atan2 hypot hypotApx ring1 ring2 ring3 ring4 sumsqr difsqr sqrsum sqrdif absdif thresh amclip scaleneg clip2 wrap2 fold2 excess + - * _

syn match scBinaryoperator "+"
syn match scBinaryoperator "-"
syn match scBinaryoperator "*"
syn match scBinaryoperator "/"
syn match scBinaryoperator "%"
syn match scBinaryoperator "\*\*"
syn match scBinaryoperator "<"
syn match scBinaryoperator "<="
syn match scBinaryoperator ">"
syn match scBinaryoperator "<>"
syn match scBinaryoperator ">="
syn match scBinaryoperator "="
syn match scBinaryoperator "=="
syn match scBinaryoperator "==="
syn match scBinaryoperator "!="
syn match scBinaryoperator "!=="
syn match scBinaryoperator "&"
syn match scBinaryoperator "|"
syn match scBinaryoperator "<!"
syn match scBinaryoperator "?"
syn match scBinaryoperator "??"
syn match scBinaryoperator "!?"
syn match scBinaryoperator "!"
syn match scBinaryoperator "#"
syn match scBinaryoperator "\.\."
syn match scBinaryoperator "\.\.\."
syn match scBinaryoperator "`"
syn match scBinaryoperator ":"

syn keyword scCommentTodo   TODO FIXME XXX TBD contained
syn match   scLineComment   "\/\/.*" contains=@Spell,scCommentTodo
syn region  scComment	      start="/\*"  end="\*/" contains=@Spell,scCommentTodo

hi def link scInfinity Number
hi def link scBinaryoperator Special
