" set relative numbering on lines
set number relativenumber
" hilights syntax
syntax on
" check for filetype to proper format it
filetype on
" colorscheme
colorscheme catppuccin_mocha 
" replace tabs with 4 spaces
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" strange windows terminal thing
set termguicolors
" set color nuber
set t_Co=256
" disable bell sound
set belloff=all
" enable smart indent
set si
" autoreload file if modifies and no local changes are applied
set autoread
