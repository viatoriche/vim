" colorscheme elflord
" colorscheme tango
" colorscheme twilight
" colorscheme dw_cyan
"colorscheme desert
" colorscheme relaxedgreen
colorscheme rdark

"map <silent><C-n> :NEXTCOLOR<cr>
"map <silent><C-p> :PREVCOLOR<cr>
"
set sc

let mapleader = "\\"
let g:EclimPythonSearchSingleResult = 'lopen'

nnoremap <Leader>d "=strftime("%c")<CR>P
"inoremap <Leader>d <C-R>=strftime("%c")<CR>

map <Leader>m :1,$s/<C-V><C-M>//g<CR>
map <Leader>s :1,$s/[ ]*$//g<CR>

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType html setfiletype htmldjango

let ropevim_vim_completion=1
let ropevim_extended_complete=1

python << EOF

import vim

def GoUrlBrowser():

  txt = vim.eval('getline(".")')

  res = re.match(".*((http|https):(//|\\\\)[^\s^\"^\'^\(^\)]+).*$", txt)
  if res != None:
    url = res.group(1)
    vim.command(':!browser '+url)
  else:
    return

EOF

map <Leader>w :python GoUrlBrowser()<CR>


set helplang=ru
"set showcmd
"set t_Co=256 

" set visualbell

" setlocal number
"
syntax on

set foldmethod=syntax
filetype on
filetype plugin on

set foldcolumn=1
set nofoldenable

"Вырубаем .swp и ~ (резервные) файлы
set nobackup
set noswapfile
set nocompatible

set viewoptions=cursor,folds
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview

" au BufReadPost :call TSkeletonMapGoToNextTag()
autocmd BufReadPost * 
  \ if line("'\"") > 0 && line("'\"") <= line("$") | 
  \   exe "normal g'\"" | 
  \ endif

" au WinEnter * :NERDTreeToggle
"
" let g:pcs_hotkey = '<LocalLeader>f'

let g:snips_author = 'Viator <viator@via-net.org>'

autocmd BufReadPost *.htm* set filetype=htmldjango

au BufNewFile *.py 0r ~/.vim/skeletons/python.py | let IndentStyle = "python"
"au BufNewFile *.py TSkeletonSetup python.py | let IndentStyle = "python"
au BufNewFile *.sh 0r ~/.vim/skel/sh.skel | let IndentStyle = "sh"
au BufNewFile *.c 0r ~/.vim/skel/c.skel | let IndentStyle = "c"

"au BufWritePost * python TryRefresh()

python << EOF

import vim

def TryRefresh():
  ok = False
  vim.command('wincmd t')
  name = vim.current.buffer.name

  if name.find('ProjectTree') != -1:
    vim.eval('eclim#tree#Refresh()')

  vim.command('wincmd W')

EOF

set completeopt=menu,longest,preview


set mouse=a
set incsearch
set nowrapscan

" Включаем подсветку выражения, которое ищется в тексте
set hlsearch
set ts=2 
set list
" " Настройка подсветки невидимых символов
set listchars=tab:·\ ,trail:·

set encoding=utf-8
set termencoding=utf-8

set fileencodings=utf-8,cp1251,cp866,koi8-r
nmap <C-N><C-N> :set invnumber <CR>

" Включаем перенос строк
set wrap
" Перенос строк по словам, а не по буквам
set linebreak

let g:pyref_mapping = 'K'

" <F7> File fileformat (dos - <CR> <NL>, unix - <NL>, mac - <CR>)
"  map <F7>	:execute RotateFileFormat()<CR>

map <C-h><C-k>    :tabprevious<CR>
imap <C-h><C-k>   <Esc>:tabprevious<CR>
vmap <C-h><C-k>   <Esc>:tabprevious<CR>
map <C-h>k    :tabprevious<CR>
imap <C-h>k   <Esc>:tabprevious<CR>
vmap <C-h>k   <Esc>:tabprevious<CR>
map <C-h><C-j>    :tabnext<CR>
imap <C-h><C-j>    <Esc>:tabnext<CR>
vmap <C-h><C-j>    <Esc>:tabnext<CR>
map <C-h>j    :tabnext<CR>
imap <C-h>j    <Esc>:tabnext<CR>
vmap <C-h>j    <Esc>:tabnext<CR>
map <C-h><C-h>    :tabnew<CR>
imap <C-h><C-h>   <Esc>:tabnew<CR>
vmap <C-h><C-h>   <Esc>:tabnew<CR>
map <C-h>h    :tabnew<CR>
imap <C-h>h   <Esc>:tabnew<CR>
vmap <C-h>h   <Esc>:tabnew<CR>
map <C-h><C-c> :q!<CR>
imap <C-h><C-c> <Esc>:q!<CR>
vmap <C-h><C-c> <Esc>:q!<CR>
map <C-h>c :q!<CR>
imap <C-h>c <Esc>:q!<CR>
vmap <C-h>c <Esc>:q!<CR>

nmap <F3>    :Explore<CR>
map <F2>    :w<CR>
imap <F2>   <Esc>:w<CR>a
nmap <F7>    :ProjectTree<CR>
nmap <F10>    :q!<CR>
nmap <c-F10>  :wq!<CR>

map <C-F8> :%s/\s\+$//e<CR>

set statusline=%<%f%h%m%r%=format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %b\ 0x%B\ %l,%c%V\ %P
"set laststatus=2
"set statusline=%{GitBranchInfoString()}
"set laststatus=2
"set statusline=%{GitBranch()}

map р h
map о j
map л k
map д l

function MyTabLine()
        let tabline = ''

        " Формируем tabline для каждой вкладки -->
            for i in range(tabpagenr('$'))
                " Подсвечиваем заголовок выбранной в данный момент вкладки.
                if i + 1 == tabpagenr()
                    let tabline .= '%#TabLineSel#'
                else
                    let tabline .= '%#TabLine#'
                endif

                " Устанавливаем номер вкладки
                let tabline .= '%' . (i + 1) . 'T'

                " Получаем имя вкладки
                let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} |'
            endfor
        " Формируем tabline для каждой вкладки <--

        " Заполняем лишнее пространство
        let tabline .= '%#TabLineFill#%T'

        " Выровненная по правому краю кнопка закрытия вкладки
        if tabpagenr('$') > 1
            let tabline .= '%=%#TabLine#%999XX'
        endif

        return tabline
endfunction

function MyTabLabel(n)
        let label = ''
        let buflist = tabpagebuflist(a:n)

        " Имя файла и номер вкладки -->
            let label = substitute(bufname(buflist[tabpagewinnr(a:n) - 1]), '.*/', '', '')

            if label == ''
                let label = '[No Name]'
            endif

            let label .= ' (' . a:n . ')'
        " Имя файла и номер вкладки <--

        " Определяем, есть ли во вкладке хотя бы один
        " модифицированный буфер.
        " -->
            for i in range(len(buflist))
                if getbufvar(buflist[i], "&modified")
                    let label = '[+] ' . label
                    break
                endif
            endfor
        " <--

        return label
endfunction

function MyGuiTabLabel()
        return '%{MyTabLabel(' . tabpagenr() . ')}'
endfunction

set tabline=%!MyTabLine()
set guitablabel=%!MyGuiTabLabel()


" Задаем собственные функции для назначения имен заголовкам табов <--


" Если вы работаете с редактором в текстовом режиме (эмулятор
" терминала, консоль), меню можна вызвать из командной строки,
" набрав в ней :emenu 
"
set wildmenu
set wildmode=longest,list

set wcm=<Tab>
"
" Образец
"    menu Encoding.menu_name      :e ++enc=encoding_name
" Юникод
    menu Encoding.UTF-8          :e ++enc=utf-8<CR>
"    menu Encoding.Unicode        :e ++enc=unicode
"    menu Encoding.UCS-2          :e ++enc=ucs-2
"    menu Encoding.UCS-4          :e ++enc=ucs-4
" Кириллические кодировки
    menu Encoding.KOI8-R         :e ++enc=koi8-r<CR>
"    menu Encoding.KOI8-U         :e ++enc=koi8-u
"    menu Encoding.KOI8-RU        :e ++enc=koi8-ru
    menu Encoding.CP1251         :e ++enc=cp1251<CR>
"    menu Encoding.IBM-855        :e ++enc=ibm855
"    menu Encoding.IBM-866        :e ++enc=ibm866
"    menu Encoding.ISO-8859-5     :e ++enc=iso-8859-5
" Latin-1
    menu Encoding.Latin-1        :e ++enc=latin1<CR>
" Определяем клавишу F8 для меню выбора кодировки
"    map  :emenu Encoding.
"
" Меню для выбора типа файла (DOS, UNIX, Mac)
    menu FileFormat.UNIX         :e ++ff=unix
    menu FileFormat.DOS          :e ++ff=dos
    menu FileFormat.Mac          :e ++ff=mac
" Определяем сочетание клавиш Shift+F8 для вызова этого меню
"    map  :emenu FileFormat. 
    menu FileEncoding.UTF-8      :set fileencoding=utf-8<CR>:w<CR>
    menu FileEncoding.KOI8-R     :set fileencoding=koi8-r<CR>:w<CR>
    menu FileEncoding.cp1251     :set fileencoding=cp1251<CR>:w<CR>
  

map <F4>  :emenu Encoding.<Tab>
imap <F4> <Esc>:emenu Encoding.<Tab>
vmap <F4> <Esc>:emenu Encoding.<Tab>

map <F5>  :emenu FileEncoding.<Tab>
imap <F5> <Esc>:emenu FileEncoding.<Tab>
vmap <F5> <Esc>:emenu FileEncoding.<Tab>


" Настраиваем переключение раскладок клавиатуры по <C-^>
set keymap=russian-jcukenwin
" Раскладка по умолчанию - английская
set imsearch=-1
set iminsert=0

        function MyKeyMapHighlight()
            if &iminsert == 0
                hi StatusLine ctermfg=DarkBlue guifg=Black
            else
                hi StatusLine ctermfg=DarkGreen guifg=Red
            endif
        endfunction

        call MyKeyMapHighlight()

        au WinEnter * :call MyKeyMapHighlight()

let g:EclimLogLevel = 0
map FC :DjangoContextOpen<cr>
map FU :DjangoViewOpen<cr>
map FF :PythonSearchContext<cr>
map FD :PythonFindDefinition<cr>
map FT :DjangoTemplateOpen<cr>
map FR :RopeRename<cr>
map <silent> <C-^>    a<C-^><Esc>:call MyKeyMapHighlight()<CR>
imap <silent> <C-^>   <C-^><Esc>:call MyKeyMapHighlight()<CR>a
vmap <silent> <C-^>   <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>

"imap <silent> <c-j> <Esc>:call TSkeletonMapGoToNextTag()<CR>
"

filetype plugin on
set omnifunc=syntaxcomplete#Complete

" omni
inoremap <c-space> <c-x><c-o>
" rope
inoremap <c-tab> <M-/>
" pydiction
inoremap <c-j> <c-x><c-k>

map FL  :PyLint<cr>

let g:pydiction_location = '/home/viator/.vim/pydiction/complete-dict'
let &dictionary = g:pydiction_location

let g:EclimPythonValidate = 1
let g:EclimMakeLCD = 0
let g:HtmlDjangoUserBodyElements = [
    \ ['repeat', 'endrepeat'],
    \ ['try', 'except', 'finally', 'endtry'],
  \ ]
let g:HtmlDjangoUserTags = []
let g:EclimDjangoStaticPaths = ["../static/"]

nmap <silent> <c-F12> :ProjectLCD<cr>
nmap <silent> <F12> :python chdir_from_filename()<cr>
nmap <F11> :ProjectTab <Tab>
nmap <c-F11> :ProjectCreate ~/Programming/<Tab><Tab>
nmap <C-h><C-c>  <F12>
nmap <C-h><C-p>  <c-F12>
nmap <C-h><C-r>  :!gvim /tmp/null.py -c PythonRegex&<cr>
nmap <silent> <c-F6> :ProjectTree<cr>
nmap <c-h><c-b>     :buffer <Tab>
imap <c-h><c-b>     <Esc>:buffer <Tab>

" Eclipse bindings

" maps Ctrl-F6 to eclipse's Ctrl-F6 key binding (switch editors)
"nmap <silent> <c-f6> :call eclim#vimplugin#FeedKeys('Ctrl+F6')<cr>

" maps Ctrl-F7 to eclipse's Ctrl-F7 key binding (switch views)
"nmap <silent> <c-f7> :call eclim#vimplugin#FeedKeys('Ctrl+F7')<cr>

" maps Ctrl-F to eclipse's Ctrl-Shift-R key binding (find resource)
"nmap <silent> <c-f> :call eclim#vimplugin#FeedKeys('Ctrl+Shift+R')<cr>

" maps Ctrl-M to eclipse's Ctrl-M binding to maximize the editor
"nmap <silent> <c-m> :call eclim#vimplugin#FeedKeys('Ctrl+M')<cr>
"

map FD   :python getpydocs()<cr>

python << EOF

import vim
import os

cb = vim.current.buffer

def getpydocs():
    vim.command('!pdc ' + cb.name + '| less')

EOF

" EPIC ADDONS
