"-----------------------------------------------------------
"        Plugins
"-----------------------------------------------------------
call plug#begin()
" Plug 'preservim/nerdtree'
Plug 'ervandew/supertab'
Plug 'airblade/vim-gitgutter'

Plug 'google/vim-jsonnet'
" for markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
let g:vim_markdown_folding_disabled = 1

" Use release branch (recommend)
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"let g:coc_disable_startup_warning = 1

call plug#end()
