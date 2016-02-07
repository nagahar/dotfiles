set clipboard+=unnamed
colorscheme mrkn256

" Tex
"let g:Tex_CompileRule_dvi = '/opt/local/bin/platex-utf8 -interaction=nonstopmode -shell-escape $*'
"let g:Tex_CompileRule_pdf = '/opt/local/bin/dvipdfmx $*.dvi'
"let g:Tex_ViewRule_pdf = 'open -a /Applications/Preview.app'

" slimv
let g:vimshell_editor_command = '/Applications/MacVim.app/Contents/MacOS/Vim --servername=VIM --remote-tab-wait-silent'
let g:slimv_lisp = '/usr/local/bin/ccl64'
let g:slimv_impl = 'clozure'
let g:slimv_preferred = 'clozure'
let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\" to do script \"ccl64 --load ~/.vim/bundle/slimv/slime/start-swank.lisp\""'
let g:paredit_mode = 0

"To enable neocomplete delete@2015-12-21
" completefunc
"au FileType python set completefunc=pythoncomplete#Complete
"au FileType javascript set completefunc=javascriptcomplete#CompleteJS
"au FileType html set completefunc=htmlcomplete#CompleteTags
"au FileType css set completefunc=csscomplete#CompleteCSS
"au FileType xml set completefunc=xmlcomplete#CompleteTags
"au FileType php set completefunc=phpcomplete#CompletePHP
"au FileType sql set completefunc=sqlcomplete#CompleteTags
"au FileType changelog set completefunc=htmlcomplete#CompleteTags
"if has('win32') || has('win64')
"    au FileType c set completefunc=syntaxcomplete#Complete
"else
"    au FileType c set completefunc=ccomplete#Complete
"endif
"au FileType *
"            \   if &l:completefunc == ''
"            \ |   setl completefunc=syntaxcomplete#Complete
"            \ | endif

