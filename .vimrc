""""""""""""""""""""""""""""""
" system configuration
""""""""""""""""""""""""""""""
if has('win32') || has('win64')
    let $CFGHOME=$HOME.'/vimfiles'
else
    let $CFGHOME=$HOME.'/.vim'
endif

let g:tinyvim = 0
source $CFGHOME/base.vimrc

