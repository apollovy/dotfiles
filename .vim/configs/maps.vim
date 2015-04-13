" Formatter mappings configs for vim

" Map window between tab movement
nnoremap <C-w>tn :call MoveToNextTab()<CR>
nnoremap <C-w>tp :call MoveToPrevTab()<CR>

" Copy current buffer path to unnamed register
nmap cp :let @" = expand("%")

cmap Qa qa
cmap QA qa
