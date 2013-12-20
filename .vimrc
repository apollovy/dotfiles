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
let g:pymode_lint_on_fly = 1
let g:pymode_lint_ignore = ""
let g:pymode_lint_sort = ['E', 'C', 'I']

" Format nearest opened braces in minimum 2 lines
map <F6>	^f(a

" Format args and kwargs separated by comma in separate lines
map <F7>	^Whr

" Format last closing brace into comma and separate line
map <F8>	$i,
" Format Redmine message
map <F5>	kdkkJi:^cwFix

" Include django's templates directories in file search
set path+=templates/,apps/*/templates/,../venv/lib/python2.7/site-packages/*/templates/

" Enable handling of local .vimvc files
set exrc

" various
set number
