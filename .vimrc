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
let pymode_lint_checker="pylint,pyflakes,pep8,mccabe,pep257"

" Format nearest opened braces in minimum 2 lines
map <F6>	^f(a

" Format Redmine message
map <F5>	kdkkJi:^cwFix

" various
set number
