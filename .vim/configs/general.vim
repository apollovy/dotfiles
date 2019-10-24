" General configs for vim

filetype plugin indent on
syntax on

" Enable handling of local .vimrc files
set exrc

" Turn line numbers on
set number

" Always axpand tabs into spaces
set expandtab

" Size of a hard tabstop
set tabstop=2

" Size of an "indent"
set shiftwidth=2

" A combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=2

" Fold equal indents
set foldmethod=indent

" Reserve 4 columns for viewing fold borders
set foldcolumn=2

" Set color scheme
colorscheme elflord

" Turn mouse on
set mouse=a

" Show invisible symbols
set listchars=eol:¶,tab:»\ ,nbsp:ꔹ
set list

" Highlight left margin column
set colorcolumn=80
set textwidth=79
