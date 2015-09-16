" Formatter mappings configs for vim

" Map window between tab movement
nnoremap <C-w>tn :call MoveToNextTab()<CR>
nnoremap <C-w>tp :call MoveToPrevTab()<CR>

" Copy current buffer path to unnamed register
nmap cp :let @" = expand("%")

cmap Qa qa
cmap QA qa

" Silence current pylint error
nnoremap <C-k> A  # pylint:disable=jf[lyt]kp:lne<CR>
