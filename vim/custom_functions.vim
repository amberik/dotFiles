function! LListToggle() abort
    let buffer_count_before = s:BufferCount()
    " Location list can't be closed if there's cursor in it, so we need 
    " to call lclose twice to move cursor to the main pane
    silent! lclose
    silent! lclose

    if s:BufferCount() == buffer_count_before
        execute "silent! lopen 10"
    endif
endfunction

function! QListToggle() abort
    let buffer_count_before = s:BufferCount()
    silent! cclose

    if s:BufferCount() == buffer_count_before
        execute "silent! botright copen 10"
    endif
endfunction

function! s:BufferCount() abort
    return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

" To Visual mode
function! ChangeVisualModInLoop()
    let l:current_mode = mode()
    let l:next_mode = l:current_mode 
    set noignorecase
    echo l:current_mode

    if 'V' == l:current_mode
        let l:next_mode = ''
    endif
    if '' == l:current_mode
        let l:next_mode = 'v'
    endif
    if 'v' == l:current_mode
        let l:next_mode = 'V'
    endif
    if 'i' == l:current_mode
        let l:next_mode = "\<ESC>\<Right>V"
    endif
    if 'n' == l:current_mode
        let l:next_mode = 'V'
    endif
    set ignorecase
    return l:next_mode
endfunction

function! VSplit()
  if bufname("%") == ""
    silent keepalt botright vertical split
  else
    let pos = getpos('.')
    silent keepalt botright vertical split %
    call cursor(pos[1],pos[0])
  endif
endfunction

"function! jedi#add_goto_window(len) 
"    set lazyredraw
"    cclose
"    let height = g:jedi#quickfix_window_height
"    execute 'belowright copen '.height
"    set nolazyredraw
"    if g:jedi#use_tabs_not_buffers == 1
"        noremap <buffer> <CR> :call jedi#goto_window_on_enter()<CR>
"    endif
"    augroup jedi_goto_window
"        au!
"        au WinLeave <buffer> q  " automatically leave, if an option is chosen
"    augroup END
"    redraw!
"endfunction
