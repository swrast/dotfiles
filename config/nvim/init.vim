filetype plugin indent on

set nu
set mouse=a

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

call plug#begin()

Plug 'OmniSharp/omnisharp-vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

let g:OmniSharp_server_use_net6 = 1
