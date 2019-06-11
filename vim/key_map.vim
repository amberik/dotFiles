"**********************************************************************************************************************
"                       KEY MAPPING
"**********************************************************************************************************************
" Fix for key combinations with ALT
for i in range(97,122)
    let c = nr2char(i)
    exec "map \e".c." <M-".c.">"
    exec "map! \e".c." <M-".c.">"
endfor

" set <Leader> later as 'a'
let mapleader = "a"
"**********************************************************************************************************************
" Window management
"**********************************************************************************************************************
" Navigation keys
" map for visual, normal, select modes
noremap  <M-i> <Up>
noremap  <M-j> <Left>
noremap  <M-k> <Down>
noremap  <M-l> <Right>

" map! for insert, command modes
noremap! <M-i> <Up>
noremap! <M-j> <Left>
noremap! <M-k> <Down>
noremap! <M-l> <Right>
inoremap <M-i> <Right><ESC><Up>
inoremap <M-j> <Left>
inoremap <M-k> <Right><ESC><Down>
inoremap <M-l> <Right>
inoremap <expr>  <M-i> pumvisible() ? "\<Up>" : "\<Right>\<ESC>\<Up>"
inoremap <expr>  <M-k> pumvisible() ? "\<Down>" : "\<Right>\<ESC>\<Down>"

map   l <Plug>(easymotion-lineforward)
map   k <Plug>(easymotion-j)
map   i <Plug>(easymotion-k)
map   j <Plug>(easymotion-linebackward)
map  <M-x> <Plug>(easymotion-bd-f2)
imap <M-x> <C-O><Plug>(easymotion-overwin-f2)
nmap <M-x> <Plug>(easymotion-overwin-f2)

nmap <silent> <M-m>l     :call LListToggle()<CR>
nmap <silent> <M-m><M-l> :call LListToggle()<CR>
nmap <silent> <M-m>q     :call QListToggle()<CR>
nmap <silent> <M-m><M-q> :call QListToggle()<CR>
	
if ! has('nvim')
    noremap I 10<Up>
    noremap J <Home>
    noremap K 10<Down>
    noremap L <End>

    noremap! I <C-o>10<Up>
    noremap! J <C-o><Home>
    noremap! K <C-o>10<Down>
    noremap! L <C-o><End>
else
    noremap <M-I> 10<Up>
"    noremap <M-J> <Home>
    noremap <M-J> ^
    noremap <M-K> 10<Down>
    noremap <M-L> g_<Right>

    noremap! <M-I> <ESC>10<Up>
    noremap! <M-J> <ESC>^
    noremap! <M-K> <ESC>10<Down>
    noremap! <M-L> <ESC>g_<Right>
endif
" Find key
nnoremap <M-q> *N
vnoremap // y/<C-R>"<CR>
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map <M-m>m     :LAg<CR>
map <M-m><M-m> :LAg<CR>
"""""""""""""""""""""""""""""""""""""
"Edit keys
"""""""""""""""""""""""""""""""""""""
" Copy
vnoremap <M-u> "ayi
nnoremap yy    "ayy

"Paste mode
nnoremap <M-p> :set invpaste paste?<CR>
set pastetoggle=<M-p>
set showmode
" Paste
inoremap <M-o> <Left><C-o>"ap
nnoremap <M-o> "ap

" Backspace
noremap  <M-d> d<Left>i
noremap! <M-d> <Backspace>
" DELETE
noremap  <M-f>  d<Right>i
noremap  dd     "add
noremap! <M-f> <Del>

" Undo
nnoremap <M-e> u
inoremap <M-e> <C-O>:stopinsert<CR>u

" Redo
nnoremap <M-r> <C-r>
inoremap <M-r> <C-o><C-r>

"""""""""""""""""""""""""""""""""""""
" Select modes
"""""""""""""""""""""""""""""""""""""
nnoremap <M-c> :startinsert<CR>

" To Normal mode
if ! has('nvim')
    vnoremap c <ESC>
    inoremap c <C-O>:stopinsert<CR>
    onoremap c <ESC>
else
    vnoremap <M-c> <ESC>
    inoremap <M-c> <C-O>:stopinsert<ESC>
    onoremap <M-c> <ESC>
endif
" To Visual mode
vnoremap <expr> <M-v>  ChangeVisualModInLoop()
inoremap <expr> <M-v>  ChangeVisualModInLoop()
nnoremap <expr> <M-v>  ChangeVisualModInLoop()
" Select the current word
nnoremap <M-u>         bve
inoremap <M-u>         <ESC>bve

"resizing of panel
nmap <silent> ( <C-W><
nmap <silent> ) <C-W>>
nmap <silent> + <C-W>+
nmap <silent> _ <C-W>-

if ! has('nvim')
    inoremap <silent> wj   <C-o>:wincmd h <CR>
    inoremap <silent> wl   <C-o>:wincmd l <CR>
    inoremap <silent> wi   <C-o>:wincmd k <CR>
    inoremap <silent> wk   <C-o>:wincmd j <CR>
    inoremap <silent> ws   <C-o>:wincmd s <CR>
    inoremap <silent> wv   <C-o>:call VSplit() <CR>
    inoremap <silent> ws     <C-o>:wincmd s <CR>
    inoremap <silent> wv     <C-o>:call VSplit() <CR>
    inoremap <silent> wq   <ESC>:lclose<CR>:cclose<CR>:q<CR>

    noremap <silent> wj    :wincmd h <CR>
    noremap <silent> wl    :wincmd l <CR>
    noremap <silent> wi    :wincmd k <CR>
    noremap <silent> wk    :wincmd j <CR>
    noremap <silent> ws    :wincmd s <CR>
    noremap <silent> wv    :call VSplit() <CR>
    noremap <silent> ws      :wincmd s <CR>
    noremap <silent> wv      :call VSplit() <CR>
    noremap <silent> wq    :lclose<CR>:cclose<CR>:q<CR>
else
    inoremap <silent> <M-w><M-j>   <C-o>:wincmd h <CR>
    inoremap <silent> <M-w><M-l>   <C-o>:wincmd l <CR>
    inoremap <silent> <M-w><M-i>   <C-o>:wincmd k <CR>
    inoremap <silent> <M-w><M-k>   <C-o>:wincmd j <CR>
    inoremap <silent> <M-w><M-s>   <C-o>:wincmd s <CR>
    inoremap <silent> <M-w><M-v>   <C-o>:call VSplit() <CR>
    inoremap <silent> <M-w>s       <C-o>:wincmd s <CR>
    inoremap <silent> <M-w>v       <C-o>:call VSplit() <CR>
    inoremap <silent> <M-w><M-q>   <ESC>:lclose<CR>:cclose<CR>:q<CR>

    noremap <silent> <M-w><M-j>    :wincmd h <CR>
    noremap <silent> <M-w><M-l>    :wincmd l <CR>
    noremap <silent> <M-w><M-i>    :wincmd k <CR>
    noremap <silent> <M-w><M-k>    :wincmd j <CR>
    noremap <silent> <M-w><M-s>    :wincmd s <CR>
    noremap <silent> <M-w><M-v>    :call VSplit() <CR>
    noremap <silent> <M-w>s        :wincmd s <CR>
    noremap <silent> <M-w>v        :call VSplit() <CR>
    noremap <silent> <M-w><M-q>    :lclose<CR>:cclose<CR>:q<CR>
endif

imap     <silent> <C-W>         <C-o><C-w>
imap     <silent> <M-w>         <C-o><C-w>
map      <silent> <M-w>         <C-w>
vnoremap <silent> <C-W><Up>     <C-W><Up>
vnoremap <silent> <C-W><Down>   <C-W><Down>
vnoremap <silent> <C-W><Right>  <C-W><Right>
vnoremap <silent> <C-W><Left>   <C-W><Left>

map <silent> <F1>       :TaskList<CR>
"Open/close directory tree
map <silent> <F2>       :NERDTreeToggle<cr>
imap <silent> <F2>      <ESC>:NERDTreeToggle<cr>
"Open/close the list of opened buffersw
map <silent> <F3>       :BufExplorer<cr>
imap <silent> <F3>      <ESC>:BufExplorer<cr>
"Open/clode the list of Tags in the current buffer
map <silent> <F4>       :TagbarToggle <CR>


"On/Off spell check
nnoremap <F7>            :set spell! spell?<CR> 
inoremap <F7>            <C-o>:set spell! spell?<CR>
" Spell suggestions
inoremap <M-n> <C-x>s
nnoremap <M-n> :startinsert<CR><C-x>s

"On/off higlight of serach results
nnoremap <F8>            :noh<CR>
inoremap <F8>            <C-o>:noh<CR>

"build of cscope DB
map <silent> <F11>  :cs reset <CR> 
map <silent> <F12>  :! ~/dotFiles/vim/cscope_build.py <CR> :cs reset<CR>

"save file
nnoremap <silent> <M-s>     :w! <CR>
inoremap <silent> <M-s>     <ESC>:w! <CR>
inoremap <silent> <Insert>  <ESC>

inoremap <expr><tab>  pumvisible() ? "\<c-n>" : "\<tab>"


let g:lt_location_list_toggle_map = '<Leader>l'
let g:lt_quickfix_list_toggle_map = '<Leader>q'
    
let g:pymode_breakpoint_key = '<leader>b'
let g:pymode_run_bind       = '<leader>r'

let g:jedi#goto_command     = '<leader>d'
" ------------------------------------------------------------------------------
" This function finds the first definition of the function/class under the
" cursor. It produces an error if the definition is not in a Python file.
let g:jedi#goto_assignments_command = '<leader>g'
"------------------------------------------------------------------------------
"This shows the pydoc documentation for the item currently under the cursor.
"The documentation is opened in a horizontally split buffer. The height of this
"buffer is controlled by `g:jedi#max_doc_height` (set by default to 30).
let g:jedi#documentation_command = '<leader>h'
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
let g:sparkupNextMapping='<c-l>'

" Haskell 
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsInfo<CR>
au FileType haskell nnoremap <buffer> <F5> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <F4> :HdevtoolsClear<CR>
" C and C++ 
augroup c_cpp_autocmds
    autocmd!
    " s: Find this C symbol
    autocmd FileType c,cpp map <silent> <M-m>s  :call CscopeFind('s', expand('<cword>'), 'n')<CR>
    " g: Find this definition
    autocmd FileType c,cpp map <silent> <M-m>g  :call CscopeFind('g', expand('<cword>'), 'n')<CR>
    " d: Find functions called by this function
    autocmd FileType c,cpp map <silent> <M-m>d  :call CscopeFind('d', expand('<cword>'), 'n')<CR>
    " c: Find functions calling this function
    autocmd FileType c,cpp map <silent> <M-m>c  :call CscopeFind('c', expand('<cword>'), 'n')<CR>
    " t: Find this text string
    autocmd FileType c,cpp map <silent> <M-m>t  :call CscopeFind('t', expand('<cword>'), 'n')<CR>
    " e: Find this egrep pattern
    autocmd FileType c,cpp map <silent> <M-m>e  :call CscopeFind('e', expand('<cword>'), 'n')<CR>
    " f: Find this file
    autocmd FileType c,cpp map <silent> <M-m>f  :call CscopeFind('f', expand('<cword>'), 'n')<CR>
    " i: Find files #including this file
    autocmd FileType c,cpp map <silent> <M-m>i  :call CscopeFind('i', expand('<cword>'), 'n')<CR>
augroup END
