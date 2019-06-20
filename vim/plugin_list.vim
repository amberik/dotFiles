call vundle#begin()
    Plugin 'gmarik/Vundle.vim'      " let Vundle manage Vundle, required
    Plugin 'bufexplorer.zip'    
    Plugin 'ervandew/supertab'
    Plugin 'xterm-color-table.vim'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'Yggdroot/indentLine'
    Plugin 'closetag.vim'
    Plugin 'ctrlp.vim'
    Plugin 'fugitive.vim'
    Plugin 'rking/ag.vim'
    Plugin 'haskell.vim'
    Plugin 'jszakmeister/vim-togglecursor'
    Plugin 'w0rp/ale'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'Valloric/ListToggle'
    Plugin 'scrooloose/nerdtree'           " Project and file navigation
    Plugin 'majutsushi/tagbar'             " Class/module browser
    Plugin 'bling/vim-airline'              " Lean & mean status/tabline for vim
    Plugin 'fisadev/FixedTaskList.vim'      " Pending tasks list
    Plugin 'rosenfeld/conque-term'          " Consoles as buffers
    Plugin 'tpope/vim-surround'            " Parentheses, brackets, quotes, XML tags, and more
    Plugin 'romainl/vim-cool'              " disables search highlighting when you are done searching and re-enables it when you search again.
    Plugin 'garbas/vim-snipmate'            " Snippets manager
    Plugin 'MarcWeber/vim-addon-mw-utils'   " dependencies #1
    Plugin 'tomtom/tlib_vim'                " dependencies #2
    Plugin 'honza/vim-snippets'             " snippets repo
    Plugin 'mitsuhiko/vim-jinja'            " Jinja support for vim
    Plugin 'eagletmt/neco-ghc'
    Plugin 'Shougo/deoplete.nvim'
    Plugin 'Hoogle'
    Plugin 'neovimhaskell/haskell-vim'
    Plugin 'bitc/vim-hdevtools'
    Plugin 'davidhalter/jedi-vim'           " Jedi-vim autocomplete plugin
    Plugin 'christoomey/vim-tmux-navigator'
call vundle#end()                    " required
