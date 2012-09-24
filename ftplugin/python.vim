" Vim filetype plugin file
" Language:	python
" Maintainer:	Johannes Zellner <johannes@zellner.org>
" Last Change:	Wed, 21 Apr 2004 13:13:08 CEST
"
" My Config >>>>>>>>
"

map <F9> :w\|!python %<cr>
imap <F9> <Esc><F9>

let python_highlight_all = 1
set ts=4
set shiftwidth=4
set expandtab
set smarttab
set number
autocmd BufWritePre *.py normal m':%s/\s\+$//e'
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

let &dictionary = g:pydiction_location
nmap <silent> <F6> :TlistAddFilesRecursive . *.py<CR>
nmap <silent> <C-h><C-g> :TSkeletonSetup python.py<CR>
nmap <F8>  :PythonSearchContext<cr>
nmap <C-h><C-s> <F8>
"map <silent> <C-,ci,ci>


" <<<<<<<<<<<<<<< My Config

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

setlocal cinkeys-=0#
setlocal indentkeys-=0#
setlocal include=^\\s*\\(from\\\|import\\)
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
setlocal suffixesadd=.py
setlocal comments-=:%
setlocal commentstring=#%s

" Debian patch: use pydoc for keyword lookup
setlocal keywordprg=~/bin/pyhelp

setlocal omnifunc=pythoncomplete#Complete

set wildignore+=*.pyc

nnoremap <silent> <buffer> ]] :call <SID>Python_jump('/^\(class\\|def\)')<cr>
nnoremap <silent> <buffer> [[ :call <SID>Python_jump('?^\(class\\|def\)')<cr>
nnoremap <silent> <buffer> ]m :call <SID>Python_jump('/^\s*\(class\\|def\)')<cr>
nnoremap <silent> <buffer> [m :call <SID>Python_jump('?^\s*\(class\\|def\)')<cr>

if exists('*<SID>Python_jump') | finish | endif

fun! <SID>Python_jump(motion) range
    let cnt = v:count1
    let save = @/    " save last search pattern
    mark '
    while cnt > 0
	silent! exe a:motion
	let cnt = cnt - 1
    endwhile
    call histdel('/', -1)
    let @/ = save    " restore last search pattern
endfun

if has("gui_win32") && !exists("b:browsefilter")
    let b:browsefilter = "Python Files (*.py)\t*.py\n" .
		       \ "All Files (*.*)\t*.*\n"
endif
