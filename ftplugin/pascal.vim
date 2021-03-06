" Vim filetype plugin file
" Language:	pascal
" Maintainer:	Dan Sharp <dwsharp at users dot sourceforge dot net>
" Last Changed: 20 Jan 2009
" URL:		http://dwsharp.users.sourceforge.net/vim/ftplugin
map <F9> :w\|!fpc %<cr>
imap <F9> <Esc><F9>

set ts=2
set shiftwidth=2
set expandtab
set smarttab
set number


if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

if exists("loaded_matchit")
    let b:match_words='\<\%(begin\|case\|try\)\>:\<end\>'
endif

" Undo the stuff we changed.
let b:undo_ftplugin = "unlet! b:match_words"
