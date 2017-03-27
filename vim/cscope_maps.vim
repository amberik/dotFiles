""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE: 
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE: 
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=1

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    " add global cscope lib
    if filereadable("/usr/include/cscope.out")
        cs add /usr/include/cscope.out /usr/include/
    endif
    " add BOOST cscope lib
    if filereadable("/home/c4dev/DEV/boost/cscope.out")
        cs add /home/c4dev/DEV/boost/cscope.out /home/c4dev/DEV/boost/
    endif

    " show msg when any other cscope db added
    set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "
    if has('quickfix')
        set cscopequickfix=s-,g-,d-,c-,t-,e-,f-,i-
    endif
    
" s: Find this C symbol
map <silent> <C-\>s  :call CscopeFind('s', expand('<cword>'), 'n')<CR>
" g: Find this definition
map <silent> <C-\>g  :call CscopeFind('g', expand('<cword>'), 'n')<CR>
" d: Find functions called by this function
map <silent> <C-\>d  :call CscopeFind('d', expand('<cword>'), 'n')<CR>
" c: Find functions calling this function
map <silent> <C-\>c  :call CscopeFind('c', expand('<cword>'), 'n')<CR>
" t: Find this text string
map <silent> <C-\>t  :call CscopeFind('t', expand('<cword>'), 'n')<CR>
" e: Find this egrep pattern
map <silent> <C-\>e  :call CscopeFind('e', expand('<cword>'), 'n')<CR>
" f: Find this file
map <silent> <C-\>f  :call CscopeFind('f', expand('<cword>'), 'n')<CR>
" i: Find files #including this file
map <silent> <C-\>i  :call CscopeFind('i', expand('<cword>'), 'n')<CR>
map <silent> <C-\>l  :call ToggleLocationList()<CR>

function! CscopeFind(action, word, split)
    try
      if(a:split == 'v')
        exe ':vert split'
      elseif(a:split == 's')
        exe ':split'
      endif
      let w:cscope_word = a:word
      let w:cscope_action = a:action
      exe ':lcs f '.w:cscope_action.' '.w:cscope_word
      exe "normal! \<c-o>"
      call Highlight_word()
      call GoToLocationList()
    catch
      echohl WarningMsg | echo 'Can not find '.a:word.' with querytype as '.a:action.'.' | echohl None
    endtry
endfunction

function! ToggleLocationList()
  let l:own = winnr()
  if exists("w:cscope_action") && exists("w:cscope_word")   
    exe ':lcs f '.w:cscope_action.' '.w:cscope_word
    exe "normal! \<c-o>"
    call Highlight_word()
  endif
  call GoToLocationList()
  let l:cwn = winnr()
  if(l:cwn == l:own)
    if &buftype == 'quickfix'
      lclose
    elseif len(getloclist(winnr())) > 0
      lclose
    else
      echohl WarningMsg | echo "No location list." | echohl None
    endif
    call Highlight_word_none()
  endif
endfunction


function! GoToLocationList()
  lw
  exe ':call MapLocationList()'
endfunction

function! MapLocationList()
  exe "nnoremap <silent> <buffer> c    :call Preview_word()<cr>"
  exe "nnoremap <silent> <buffer> <cr> :call Go_word()<cr>"
endfunction

function! Highlight_word()
  if exists("w:cscope_word")
    exe 'match Todo /\%'.line('.').'l'.w:cscope_word.'/'
  endif
endfunction

function! Preview_word()
  exe "normal! \<cr>"
  call Highlight_word()
  exe "normal! \<c-w>\<c-w>"
endfunction

function! Go_word()
  exe "normal! \<cr>"
  if exists("w:cscope_word")
    call Highlight_word()
  endif
endfunction

function! Highlight_word_none()
  exe ':match none'
endfunction
    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	

    " s: Find this C symbol
    map <silent> <C-@>s  :call CscopeFind('s', expand('<cword>'), 's')<CR>
    " g: Find this definition
    map <silent> <C-@>g  :call CscopeFind('g', expand('<cword>'), 's')<CR>
    " d: Find functions called by this function
    map <silent> <C-@>d  :call CscopeFind('d', expand('<cword>'), 's')<CR>
    " c: Find functions calling this function
    map <silent> <C-@>c  :call CscopeFind('c', expand('<cword>'), 's')<CR>
    " t: Find this text string
    map <silent> <C-@>t  :call CscopeFind('t', expand('<cword>'), 's')<CR>
    " e: Find this egrep pattern
    map <silent> <C-@>e  :call CscopeFind('e', expand('<cword>'), 's')<CR>
    " f: Find this file
    map <silent> <C-@>f  :call CscopeFind('f', expand('<cword>'), 's')<CR>
    " i: Find files #including this file
    map <silent> <C-@>i  :call CscopeFind('i', expand('<cword>'), 's')<CR>


    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    " s: Find this C symbol
    map <silent> <C-\><C-\>s  :call CscopeFind('s', expand('<cword>'), 'v')<CR>
    " g: Find this definition
    map <silent> <C-\><C-\>g  :call CscopeFind('g', expand('<cword>'), 'v')<CR>
    " d: Find functions called by this function
    map <silent> <C-\><C-\>d  :call CscopeFind('d', expand('<cword>'), 'v')<CR>
    " c: Find functions calling this function
    map <silent> <C-\><C-\>c  :call CscopeFind('c', expand('<cword>'), 'v')<CR>
    " t: Find this text string
    map <silent> <C-\><C-\>t  :call CscopeFind('t', expand('<cword>'), 'v')<CR>
    " e: Find this egrep pattern
    map <silent> <C-\><C-\>e  :call CscopeFind('e', expand('<cword>'), 'v')<CR>
    " f: Find this file
    map <silent> <C-\><C-\>f  :call CscopeFind('f', expand('<cword>'), 'v')<CR>
    " i: Find files #including this file
    map <silent> <C-\><C-\>i  :call CscopeFind('i', expand('<cword>'), 'v')<CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
        "
            "set timeoutlen=4000
             "
             " Either way, since mapping timeout settings by default also set the
             " timeouts for multicharacter 'keys codes' (like <F1>), you should also
             " set ttimeout and ttimeoutlen: otherwise, you will experience strange
             " delays as vim waits for a keystroke after you hit ESC (it will be
             " waiting to see if the ESC is actually part of a key code like <F1>).
             "
             "set ttimeout 
             "
             " personally, I find a tenth of a second to work well for key code
             " timeouts. If you experience problems and have a slow terminal or network
             " connection, set it higher.  If you don't set ttimeoutlen, the value for
             " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
             "
             "set ttimeoutlen=100

endif
