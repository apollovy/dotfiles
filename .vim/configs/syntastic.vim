" Syntastic configs for vim
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" let g:syntastic_python_checkers = ["flake8", "frosted", "mypy", "pep257", "pep8", "prospector", "py3kwarn", "pyflakes", "pylama", "pylint", "python"]
let g:syntastic_python_checkers = ["pep257", "pep8", "py3kwarn", "pylint"]

fun! Check_syntax()
  :let b:syntastic_skip_checks=0
  :SyntasticCheck
endfun
nnoremap <C-l> :call Check_syntax()<CR>
