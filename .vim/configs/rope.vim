" Rope config for vim

" ropevim_codeassist_maxfixes:
" The maximum number of syntax errors to fix for code assists. The default
" value is 1.
"
" ropevim_local_prefix:
" The prefix for ropevim refactorings. Defaults to C-c r.
"
" ropevim_global_prefix:
" The prefix for ropevim project commands Defaults to C-x p.
"
" ropevim_enable_shortcuts:
" Shows whether to bind ropevim shortcuts keys. Defaults to 1.
"
" ropevim_autoimport_underlineds:
" If set, autoimport will cache names starting with underlines, too.

" g:ropevim_open_files_in_tabs:
" If non-zero, ropevim will open files in tabs. This is disabled by default.

let ropevim_guess_project=1
" If non-zero, ropevim tries to guess and open the project that contains the file on which a ropevim command is performed when no project is already open.

let ropevim_enable_autoimport=0
" Shows whether to enable autoimport.

let ropevim_autoimport_modules=["openerp.osv"]
" The name of modules whose global names should be cached. RopeGenerateAutoimportCache reads this list and fills its cache.

let ropevim_goto_def_newwin=1
" If set, ropevim will open a new buffer for "go to definition" result if the definition found is located in another file. By default the file is open in the same buffer.

" imap  :RopeLuckyAssist

let ropevim_vim_completion=0
