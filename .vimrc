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

" various
set number

" Map window between tab movement
nnoremap <C-w>tn :call MoveToNextTab()<CR>
nnoremap <C-w>tp :call MoveToPrevTab()<CR>
