" Vim filetype plugin file
" Language:         Haskell
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2008-07-09


map <F9> :w\|!ghc %<cr>
imap <F9> <Esc><F9>

set ts=2
set shiftwidth=2
set expandtab
set smarttab
set number
autocmd BufWritePre *.hs normal m`:%s/\s\+$//e ``

map <silent> <F6> :TlistAddFilesRecursive . *.hs<CR>

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

let b:undo_ftplugin = "setl com< cms< fo<"

setlocal comments=s1fl:{-,mb:-,ex:-},:-- commentstring=--\ %s
setlocal formatoptions-=t formatoptions+=croql

let &cpo = s:cpo_save
unlet s:cpo_save
