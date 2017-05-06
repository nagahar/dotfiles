"----------------------------------------
" system configuration
"----------------------------------------

set noerrorbells
set novisualbell
set visualbell t_vb=

if has('multi_byte_ime') || has('xim')
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    "set imactivatekey=C-space
  endif
endif

"----------------------------------------
" display configuration
"----------------------------------------
" english menu
"set langmenu=en

set cmdheight=2

" color
"colorscheme desert
"colorscheme desertExMe
colorscheme mrkn256

" font
set linespace=1
if has('win32') || ('win64')
  set guifont=MS_Gothic:h11:cSHIFTJIS
  set guifontwide=MS_Gothic:h11:cSHIFTJIS
  set linespace=0
  "source $VIMRUNTIME/delmenu.vim
  set langmenu=ja_jp.utf-8
  "source $VIMRUNTIME/menu.vim
elseif has('mac')
  set guifont=Osaka-Mono:h14
  set guifontwide=Osaka-Mono:h12
  " for antialias
  "set nomacatsui
  set anti
  " for japanese antialias mojibake
  set termencoding=japan
  " for menu mojibake
  "source $VIMRUNTIME/delmenu.vim
  set langmenu=menu_ja_jp.utf-8.vim
  "source $VIMRUNTIME/menu.vim
elseif has('xfontset')
  set guifontset=a14,r14,k14
  set linespace=0
elseif has('unix')
  set guifont=M+2VM+IPAG\ circle\ 14
  set guifont=M+2VM+IPAG\ circle\ 12
endif

"set lines=80
"set columns=50

""""""""""""""""""""""""""""""
" set windows position
""""""""""""""""""""""""""""""
"if 1 && has('gui_running')
"  if has('unix')
"    let s:infofile = '~/.vimpos'
"  else
"    let s:infofile = '~/_vimpos'
"  endif
"
"  function! s:WinPosSizeSave(filename)
"    let saved_reg = @a
"    redir @a
"    winpos
"    redir END
"    let px = substitute(@a, '.*X \(\d\+\).*', '\1', '') + 0
"    let py = substitute(@a, '.*Y \(\d\+\).*', '\1', '') + 0
"    execute 'redir! >'.a:filename
"    if px > 0 && py > 0
"      echo 'winpos '.px.' '.py
"    endif
"    echo 'set lines='.&lines.' columns='.&columns
"    redir END
"    let @a = saved_reg
"  endfunction
"
"  augroup WinPosSizeSaver
"    autocmd!
"  augroup END
"  execute 'autocmd WinPosSizeSaver VimLeave * call s:WinPosSizeSave("'.s:infofile.'")'
"  if filereadable(expand(s:infofile))
"    execute 'source '.s:infofile
"  endif
"  unlet s:infofile
"endif


" vim singleton

"if has('win32') || has('win64')
"    call singleton#enable()
"endif

if has('kaoriya')
  set noimdisableactivate
endif
