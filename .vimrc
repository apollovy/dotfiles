" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

" Search-related settings
set hlsearch
set incsearch
set smartcase

" pymode
let g:pymode_lint_checkers = ['pylint', 'pyflakes', 'pep8', 'mccabe', 'pep257']
let g:pymode_lint_unmodified = 1
let g:pymode_lint_ignore = ""

" Format Redmine message
map <F5>	kdkkJi:^cwFix

" Format nearest opened braces in minimum 2 lines
map <F6>	^f(a

" Format args and kwargs separated by comma in separate lines
map <F7>	^f,a

" Format last closing brace into comma and separate line
map <F8>	$i,j

" Include django's templates directories in file search
set path+=templates/,apps/*/templates/,../venv/lib/python2.7/site-packages/*/templates/

" Enable handling of local .vimrc files
set exrc

" Turn line numbers on
set number
" Always axpand tabs into spaces
set expandtab
" Size of a hard tabstop
set tabstop=4
" Size of an "indent"
set shiftwidth=4
" A combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4
" Fold equal indents
set foldmethod=indent
" Reserve 4 columns for viewing fold borders
set foldcolumn=4
" Set color scheme
colorscheme elflord
" Turn mouse on
set mouse=a

" Map window between tab movement
nnoremap <C-w>tn :call MoveToNextTab()<CR>
nnoremap <C-w>tp :call MoveToPrevTab()<CR>
