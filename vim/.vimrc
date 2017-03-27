"uthor: Klaus Franken     <kfr@suse.de>
" author: Werner Fink       <werner@suse.de> 
" author: Florian La Roche  <florian@suse.de> 
" version: 00/01/20
" commented lines start with `"'

" get easier to use and more user friendly vim defaults
" CAUTION: This option breaks some vi compatibility. 
"          Switch it off if you prefer real vi compatibility
set nocompatible              " be iMproved, required

" enable syntax highlighting
syntax on

" automatically indent lines (default)
" set noautoindent

" select case-insenitiv search (not default)
set ignorecase

set number

" show cursor line and column in the status line
set ruler

" show matching brackets
set showmatch

" display mode INSERT/REPLACE/...
set showmode

" changes special characters in search patterns (default)
" set magic

" Required to be able to use keypad keys and map missed escape sequences
set esckeys

" allow backspacing over everything in insert mode 
set backspace=indent,eol,start

set hlsearch

" Enable mouse usage (all modes)
set mouse=a        

" Do smart case matching
set smartcase

" Incremental search
set incsearch 

" Disable swap file creation
set noswapfile

" Disable word wrap
set nowrap

set timeoutlen=1000 ttimeoutlen=0

set spell

set t_Co=256

" replace tab with spaces
set expandtab

set tabstop=4

set shiftwidth=4

set smarttab


"********************************************************************************************************************
"=====================================================
"" Vundle settings
"=====================================================
"" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/vim-airline-themes/
call vundle#begin()
    
    Plugin 'gmarik/Vundle.vim'      " let Vundle manage Vundle, required
    Plugin 'bufexplorer.zip'    
    Plugin 'ervandew/supertab'
    Plugin 'xterm-color-table.vim'
    Plugin 'noah/vim256-color'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'vim-airline/vim-airline-themes'

    "---------=== Code/project navigation ===-------------
    Plugin 'scrooloose/nerdtree'           " Project and file navigation
    Plugin 'majutsushi/tagbar'             " Class/module browser
    "
    ""------------------=== Other ===----------------------
    Plugin 'bling/vim-airline'              " Lean & mean status/tabline for vim
    Plugin 'fisadev/FixedTaskList.vim'      " Pending tasks list
    Plugin 'rosenfeld/conque-term'          " Consoles as buffers
    "Plugin 'tpope/vim-surround'     " Parentheses, brackets, quotes, XML tags, and more

    "--------------=== Snippets support ===---------------
    Plugin 'garbas/vim-snipmate'       " Snippets manager
    Plugin 'MarcWeber/vim-addon-mw-utils'  " dependencies #1
    Plugin 'tomtom/tlib_vim'       " dependencies #2
    Plugin 'honza/vim-snippets'        " snippets repo
    "
    ""---------------=== Languages support ===-------------
    " --- Python ---
    Plugin 'klen/python-mode'            " Python mode (docs, refactor,
    "  lints, highlighting, run and ipdb and more)
    Plugin 'davidhalter/jedi-vim'        " Jedi-vim autocomplete plugin
    Plugin 'mitsuhiko/vim-jinja'     " Jinja support for vim
    Plugin 'mitsuhiko/vim-python-combined'  " Combined Python 2/3 for Vim

call vundle#end()                    " required

filetype on
filetype plugin on
filetype plugin indent on

colorscheme fu


" disable tabs replacement for the specified filetypes
au FileType crontab,fstab,make set noexpandtab tabstop=8 shiftwidth=8

augroup vimrc_autocmds
    autocmd!
    autocmd FileType ruby,python,javascript,c,cpp set colorcolumn=0
    autocmd FileType ruby,python,javascript,c,cpp set nowrap
augroup END

autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>


set laststatus=2
let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_exclude_preview=1


" auto indent
set ai

" C-style indent
set cin

set path+=/usr/include/**
set path+=./**

"set tags=tags;/
set tags=/usr/include/tags
set tags+=./tags

"**********************************************************************************************************************
" NERDTree
let g:NERDTreeBookmarksFile = expand('%:p:h')."/.BookMarks"

"**********************************************************************************************************************
" Tilst_settings
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Sort_Type = "name"
"**********************************************************************************************************************
"=====================================================
" Languages support
"=====================================================
" --- Python ---
"autocmd FileType python set completeopt-=preview " раскомментируйте, в случае, если не надо, чтобы jedi-vim показывал документацию по методу/классу
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
\ formatoptions+=croq softtabstop=4 smartindent
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
autocmd FileType pyrex setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
" --- JavaScript ---
let javascript_enable_domhtmlcss=1
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd BufNewFile,BufRead *.json setlocal ft=javascript
" --- HTML ---
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" --- template language support (SGML / XML too) ---
autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd bufnewfile,bufread *.rhtml setlocal ft=eruby
autocmd BufNewFile,BufRead *.mako setlocal ft=mako
autocmd BufNewFile,BufRead *.tmpl setlocal ft=htmljinja
autocmd BufNewFile,BufRead *.py_tmpl setlocal ft=python
autocmd FileType html,htmldjango,htmljinja,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako source ~/.vim/scripts/closetag.vim
" --- CSS ---
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
" --- YUML ---
autocmd FileType yml,yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2


let html_no_rendering=1
let g:closetag_default_xml=1
let g:sparkupNextMapping='<c-l>'

"=====================================================
" Python-mode settings
"=====================================================
" отключаем автокомплит по коду (у нас вместо него используется jedi-vim)
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" проверка кода
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_ignore="E501,W601,C0110"
let g:pymode_lint_cwindow = 1
" провека кода после сохранения
let g:pymode_lint_on_write = 0
map <silent> <leader>c :PymodeLint <CR> 

" поддержка virtualenv
let g:pymode_virtualenv = 1

" установка breakpoints
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" подстветка синтаксиса
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" отключить autofold по коду
let g:pymode_folding = 0

" возможность запускать код
let g:pymode_run = 0
let g:pymode_run_bind = '<leader>r'

let g:pymode_doc = 0
let g:pymode_doc_bind = ''


let g:jedi#popup_select_first = 1
let g:jedi#show_call_signatures = 1
let g:jedi#auto_close_doc = 1
set splitbelow
let g:jedi#goto_command = '<leader>d'

" ------------------------------------------------------------------------------
" This function finds the first definition of the function/class under the
" cursor. It produces an error if the definition is not in a Python file.
let g:jedi#goto_assignments_command = '<leader>g'

"------------------------------------------------------------------------------
"This shows the pydoc documentation for the item currently under the cursor.
"The documentation is opened in a horizontally split buffer. The height of this
"buffer is controlled by `g:jedi#max_doc_height` (set by default to 30).

let g:jedi#documentation_command = '<leader>k'

"------------------------------------------------------------------------------
"Jedi-vim deletes the word currently under the cursor and puts Vim in insert
"mode, where the user is expected to enter the new variable name. Upon leaving
"insert mode, jedi-vim then renames all occurences of the old variable name
"with the new one. The number of performed renames is displayed in the command
"line.

let g:jedi#rename_command = '<leader>r'

"------------------------------------------------------------------------------
"The quickfix window is populated with a list of all names which point to the
"definition of the name under the cursor.

let g:jedi#usages_command = '<leader>]'



"**********************************************************************************************************************
"resizing of panel
nmap <silent> ( <C-W><
nmap <silent> ) <C-W>>
nmap <silent> + <C-W>+
nmap <silent> _ <C-W>-

"build of cscope DB
map <silent> <F11>  :cs reset <CR> 
map <silent> <F12>  :! /usr/share/vim/cscope_build.sh -f ../cscope.paths & <CR>
map <silent> <C-\>v  :Ag<CR>

"nnoremap <silent> <C-Left>  :wincmd h <CR>
"nnoremap <silent> <C-Right>  :wincmd l <CR>
"nnoremap <silent> <C-Up>  :wincmd k <CR>
"nnoremap <silent> <C-Down>  :wincmd j <CR>
"**********************************************************************************************************************
" OmniCppComplete
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"let OmniCpp_MayCompleteDot = 1 " autocomplete after .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"set complete-=i
" " automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview
"autocmd FileType cpp set omnifunc=omni#cpp#complete#Main
"autocmd FileType c set omnifunc=ccomplete#Complete
"**********************************************************************************************************************
" Complete longest common string, then each full match
" enable this for bash compatible behaviour
" set wildmode=longest,full

" Try to get the correct main terminal type
if &term =~ "xterm"
let myterm = "xterm"
else
let myterm =  &term
endif
let myterm = substitute(myterm, "cons[0-9][0-9].*$",  "linux", "")
let myterm = substitute(myterm, "vt1[0-9][0-9].*$",   "vt100", "")
let myterm = substitute(myterm, "vt2[0-9][0-9].*$",   "vt220", "")
let myterm = substitute(myterm, "\\([^-]*\\)[_-].*$", "\\1",   "")

" Here we define the keys of the NumLock in keyboard transmit mode of xterm
" which misses or hasn't activated Alt/NumLock Modifiers.  Often not defined
" within termcap/terminfo and we should map the character printed on the keys.
if myterm == "xterm" || myterm == "kvt" || myterm == "gnome"
" keys in insert/command mode.
map! <ESC>Oo  :
map! <ESC>Oj  *
map! <ESC>Om  -
map! <ESC>Ok  +
map! <ESC>Ol  ,
    map! <ESC>OM  
    map! <ESC>Ow  7
    map! <ESC>Ox  8
    map! <ESC>Oy  9
    map! <ESC>Ot  4
    map! <ESC>Ou  5
    map! <ESC>Ov  6
    map! <ESC>Oq  1
    map! <ESC>Or  2
    map! <ESC>Os  3
    map! <ESC>Op  0
    map! <ESC>On  .
    " keys in normal mode
    map <ESC>Oo  :
    map <ESC>Oj  *
    map <ESC>Om  -
    map <ESC>Ok  +
    map <ESC>Ol  ,
    map <ESC>OM  
    map <ESC>Ow  7
    map <ESC>Ox  8
    map <ESC>Oy  9
    map <ESC>Ot  4
    map <ESC>Ou  5
    map <ESC>Ov  6
    map <ESC>Oq  1
    map <ESC>Or  2
    map <ESC>Os  3
    map <ESC>Op  0
    map <ESC>On  .
    endif

    " xterm but without activated keyboard transmit mode
    " and therefore not defined in termcap/terminfo.
    if myterm == "xterm" || myterm == "kvt" || myterm == "gnome"
    " keys in insert/command mode.
    map! <Esc>[H  <Home>
    map! <Esc>[F  <End>
    " Home/End: older xterms do not fit termcap/terminfo.
    map! <Esc>[1~ <Home>
    map! <Esc>[4~ <End>
    " Up/Down/Right/Left
    map! <Esc>[A  <Up>
    map! <Esc>[B  <Down>
    map! <Esc>[C  <Right>
    map! <Esc>[D  <Left>
    " KP_5 (NumLock off)
    map! <Esc>[E  <Insert>
    " keys in normal mode
    map <ESC>[H  0
    map <ESC>[F  $
    " Home/End: older xterms do not fit termcap/terminfo.
    map <ESC>[1~ 0
    map <ESC>[4~ $
    " Up/Down/Right/Left
    map <ESC>[OA  k
    map <ESC>[OB  j
    map <ESC>[OC  l
    map <ESC>[OD  h
    " KP_5 (NumLock off)
    map <ESC>[E  i
    endif

    " xterm/kvt but with activated keyboard transmit mode.
    " Sometimes not or wrong defined within termcap/terminfo.
    if myterm == "xterm" || myterm == "kvt" || myterm == "gnome"
    " keys in insert/command mode.
    map! <Esc>OH <Home>
    map! <Esc>OF <End>
    map! <ESC>O2H <Home>
    map! <ESC>O2F <End>
    map! <ESC>O5H <Home>
    map! <ESC>O5F <End>
    " Cursor keys which works mostly
    " map! <Esc>OA <Up>
    " map! <Esc>OB <Down>
    " map! <Esc>OC <Right>
    " map! <Esc>OD <Left>
    map! <Esc>[2;2~ <Insert>
    map! <Esc>[3;2~ <Delete>
    map! <Esc>[2;5~ <Insert>
    map! <Esc>[3;5~ <Delete>
    map! <Esc>O2A <PageUp>
    map! <Esc>O2B <PageDown>
    map! <Esc>O2C <S-Right>
    map! <Esc>O2D <S-Left>
    map! <Esc>O5A <PageUp>
    map! <Esc>O5B <PageDown>
    map! <Esc>O5C <S-Right>
    map! <Esc>O5D <S-Left>
    " KP_5 (NumLock off)
    map! <Esc>OE <Insert>
    " keys in normal mode
    map <ESC>OH  0
    map <ESC>OF  $
    map <ESC>O2H  0
    map <ESC>O2F  $
    map <ESC>O5H  0
    map <ESC>O5F  $
    " Cursor keys which works mostly
    " map <ESC>OA  k
    " map <ESC>OB  j
    " map <ESC>OD  h
    " map <ESC>OC  l
    map <Esc>[2;2~ i
    map <Esc>[3;2~ x
    map <Esc>[2;5~ i
    map <Esc>[3;5~ x
    map <ESC>O2A  ^B
    map <ESC>O2B  ^F
    map <ESC>O2D  b
    map <ESC>O2C  w
    map <ESC>O5A  ^B
    map <ESC>O5B  ^F
    map <ESC>O5D  b
    map <ESC>O5C  w
    " KP_5 (NumLock off)
    map <ESC>OE  i
    endif

    if myterm == "linux"
    " keys in insert/command mode.
    map! <Esc>[G  <Insert>
    " KP_5 (NumLock off)
    " keys in normal mode
    " KP_5 (NumLock off)
    map <ESC>[G  i
    endif

    " This escape sequence is the well known ANSI sequence for
    " Remove Character Under The Cursor (RCUTC[tm])
"    map! <Esc>[3~ <Delete>
    map  <ESC>[3~    x

    " Only do this part when compiled with support for autocommands. 
    if has("autocmd") 
    " When editing a file, always jump to the last known cursor position. 
    " Don't do it when the position is invalid or when inside an event handler 
    " (happens when dropping a file on gvim). 
    autocmd BufReadPost * 
    \ if line("'\"") > 0 && line("'\"") <= line("$") | 
    \   exe "normal g`\"" | 
    \ endif 

    endif " has("autocmd")

    " Changed default required by SuSE security team--be aware if enabling this
    " that it potentially can open for malicious users to do harmful things.
    set nomodeline

    " get easier to use and more user friendly vim defaults

"**********************************************************************************************************************
"map <ESC>[A <C-Up> 
"map <ESC>[B <C-Down>
"map <ESC>[D <C-Left>
"map <ESC>[C <C-Right>
"map <ESC>[[A <F1>
"map <ESC>[[B <F2>
"map <ESC>[[C <F3>
"map <ESC>[[D <F4>
map <silent> <F1> :TaskList<CR>
"Open/close directory tree
map <silent> <F2>       :NERDTreeToggle<cr>
"Open/close the list of opened buffers
map <silent> <F3>       :BufExplorer<cr>
"Open/clode the list of Tags in the current buffer
map <silent> <F4>       :TagbarToggle <CR>

" run python script
nnoremap <F5> :ConqueTermSplit ipython<CR>
" а debug-mode <F6>
nnoremap <F6> :exe "ConqueTermSplit ipython " . expand("%")<CR>
let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_CloseOnEnd = 0

"show/hide indentation lines
noremap <F7>            :IndentGuidesToggle<CR>
"On/off higlight of serach results
noremap <F8>            :set hlsearch! hlsearch?<CR>
"save file
nmap <silent> <C-s>     :w! <CR>
imap <silent> <C-s>     <ESC>:w! <CR>
"select the current word
map <silent> <C-x>      <ESC>viw
imap <silent> <Insert>  <ESC>

"navigation between panels
imap <silent> <C-w>         <C-o><C-w>
imap <silent> <C-W><Up>     <ESC><C-W><Up>
imap <silent> <C-W><Down>   <ESC><C-W><Down>
imap <silent> <C-W><Right>  <ESC><C-W><Right>
imap <silent> <C-W><Left>   <ESC><C-W><Left>
vmap <silent> <C-W><Up>     <ESC><C-W><Up>
vmap <silent> <C-W><Down>   <ESC><C-W><Down>
vmap <silent> <C-W><Right>  <ESC><C-W><Right>
vmap <silent> <C-W><Left>   <ESC><C-W><Left>

imap <silent> <C-W>k     <ESC><C-W><Up>
imap <silent> <C-W>j   <ESC><C-W><Down>
imap <silent> <C-W>l  <ESC><C-W><Right>
imap <silent> <C-W>h   <ESC><C-W><Left>
vmap <silent> <C-W>k     <ESC><C-W><Up>
vmap <silent> <C-W>j   <ESC><C-W><Down>
vmap <silent> <C-W>h  <ESC><C-W><Right>
vmap <silent> <C-W>l   <ESC><C-W><Left>

    " /etc/vimrc ends here 
