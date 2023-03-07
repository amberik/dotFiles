"=====================================================
" Languages support
"=====================================================
" --- C and C++ ---
so ~/dotFiles/vim/cscope_maps.vim

let g:ag_lhandler="rightbelow lw"

let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {'python':['flake8'], 'cpp':[], 'c':[]}

let g:ale_python_flake8_options = '--ignore=E501,E221,E731,E241,E251,E272'
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1


set laststatus=2
let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_exclude_preview=1

let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Sort_Type = "name"

"=====================================================
" Python-mode settings
"=====================================================
" Disable python code auto complete (will use jedi-vim)
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
" Do NOT Code checking for python (Lint)
let g:pymode_lint = 0
" virtualenv support
let g:pymode_virtualenv = 1
" Set of breakpoints in python
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'
" Python syntax
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
" Disable autofold in python code
let g:pymode_folding = 0
" Support of run of python code
let g:pymode_run = 0
let g:pymode_run_bind = '<leader>r'
let g:pymode_doc = 0
let g:pymode_doc_bind = ''



"=====================================================
" Deoplete autocomplete settings
"=====================================================
" deoplete options
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
"" disable autocomplete by default
let b:deoplete_disable_auto_complete=1
let g:deoplete_disable_auto_complete=1
"call deoplete#custom#buffer_option('auto_complete', v:false)

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

" Disable the candidates in Comment/String syntaxes.
"call deoplete#custom#source('_',
"            \ 'disabled_syntaxes', ['Comment', 'String'])

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" set sources
let g:deoplete#sources = {}
let g:deoplete#sources.cpp = ['LanguageClient']
"let g:deoplete#sources.python = ['LanguageClient']
"let g:deoplete#sources.python3 = ['LanguageClient']
let g:deoplete#sources.c = ['LanguageClient']
"let g:deoplete#sources.haskell = ['LanguageClient']
let g:deoplete#sources.vim = ['vim']

" Use <c-space> to trigger completion.
"inoremap <silent><expr> <m-b> coc#refresh()

" ------------------------------------------------------------------------------
" Haskell
" ------------------------------------------------------------------------------

"let g:hoogle_search_count = 100
"let g:haskellmode_completion_ghc = 0
"autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

"let html_no_rendering=1
"let g:closetag_default_xml=1

"let g:indentLine_color_term = 236
"let g:indentLine_char = '┋'
" ------------------------------------------------------------------------------
" TMUX integration
" ------------------------------------------------------------------------------
let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_no_mappings = 1
" ------------------------------------------------------------------------------
" NERDTree
" ------------------------------------------------------------------------------
let g:NERDTreeBookmarksFile = expand('%:p:h')."/.BookMarks"
let g:NERDTreeUpdateOnCursorHold = 0
"let g:NERDTreeGitStatusWithFlags = 1
" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr("t:NERDTreeBufName") != -1)
endfunction
" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && !&diff && strlen(expand('%')) > 0 && IsNERDTreeOpen()
    "NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

