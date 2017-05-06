set clipboard+=unnamed
colorscheme mrkn256

" slimv
if IsNeobundled('slimv')
    let g:vimshell_editor_command = '/Applications/MacVim.app/Contents/MacOS/Vim --servername=VIM --remote-tab-wait-silent'
    let g:slimv_lisp = '/usr/local/bin/ccl64'
    let g:slimv_impl = 'clozure'
    let g:slimv_preferred = 'clozure'
    let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\" to do script \"ccl64 --load ~/.vim/bundle/slimv/slime/start-swank.lisp\""'
    let g:paredit_mode = 0
endif

" Tex
"let g:Tex_CompileRule_dvi = '/opt/local/bin/platex-utf8 -interaction=nonstopmode -shell-escape $*'
"let g:Tex_CompileRule_pdf = '/opt/local/bin/dvipdfmx $*.dvi'
"let g:Tex_ViewRule_pdf = 'open -a /Applications/Preview.app'

