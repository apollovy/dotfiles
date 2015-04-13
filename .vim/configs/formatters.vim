" Formatter mappings configs for vim

" Format Redmine message
map <F5>	kdkkJi:^cwFix

" Format nearest opened braces in minimum 2 lines
map <F6>	^f(a

" Format args and kwargs separated by comma in separate lines
map <F7>	^f,a

" Format last closing brace into comma and separate line
map <F8>	$i,j

" JsBeautify
map <c-f> :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" Format XML files
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
