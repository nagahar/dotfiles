"-----------------------------------------------------------------------------
"   コンフィギュレーション（環境に応じて変更のこと）
"-----------------------------------------------------------------------------
let g:vimsh_script_path = "bundle/vimsh/macros/vimsh.vim"
let g:scheme_gauche_lib = "/opt/local/share/gauche/0.9/lib/"
let is_gauche=1

"-----------------------------------------------------------------------------
"   Scheme 用設定
"-----------------------------------------------------------------------------

augroup Scheme_Autocmd
  au!
  au FileType vim_shell inoremap <buffer> <C-p> <C-x><C-l>
  au Syntax scheme syn match  MySchemeFalse /#f/ | hi MySchemeFalse ctermfg=2
augroup END
nnoremap <silent> <C-c>s :sil! call FtOpenVimsh(&ft)<CR>
nnoremap <silent> <buffer> <F5> :!gosh < %<CR>
nnoremap <buffer> <F3> ==j
nnoremap <buffer> <CR><CR> :<C-u>call Scheme_EvalExpr()<CR><Esc>l
inoremap <buffer> <C-x><C-e> x<Esc>mz:call search(')','bc')<CR>:call Scheme_EvalExpr()<CR><Esc>`zs
nnoremap <buffer> K :<C-u>!gosh -u gauche.interactive -E "info '"'<cword>' -E exit<CR>
nnoremap <buffer> vs va)
onoremap <buffer> s a)
" use, load しているファイルを補完対象に含める。gf などにも関係。
setlocal suffixesadd=.scm
setlocal include=(use\ \\\|(load\
setlocal includeexpr=substitute(substitute(v:fname,'\\./','','g'),'\\.','/','g')
let &l:path .= g:scheme_gauche_lib

function! Scheme_EvalExpr()
  let pos_save     = getpos(".")
  let reg_save     = getreg("z")
  let regtype_save = getregtype("z")
  normal! "zya)

  if !bufexists("_scheme_")
    call FtOpenVimsh("scheme")
  endif

  call VimshExecCmd("scheme", @z)
  call setreg("z", reg_save, regtype_save)
  call setpos(".", pos_save)
endfunction

"-----------------------------------------------------------------------------
"   補助関数
"-----------------------------------------------------------------------------
" 指定した名前を持つバッファが既に存在するならそこにカーソルを移動。
" 存在しないなら作成。
function! SingletonBuffer(name, split)
  " 文字をエスケープ :h file-pattern
  let name=escape(a:name, '[]*?,\')
  if bufexists(a:name) " bufexists にはエスケープ必要ない
    let bufnr = bufnr(name)
    let winlist = FindWindowsByBufnr(bufnr)
    if empty(winlist)
      if a:split
	    "split
	    vsplit
      endif
      exe "b " . bufnr
    else
      exe winlist[0] . "wincmd w"
    endif
  else
    if a:split
      exe "sil new " . escape(name, ' ')
    else
      exe "sil e " . escape(name, ' ')
    endif
  endif
endfunction

" 指定したバッファを含んでいるウィンドウ番号のリストを返す。
function! FindWindowsByBufnr(bufnr)
  return filter(range(1, winnr("$")), 'winbufnr(v:val)==' . a:bufnr)
endfunction

"-----------------------------------------------------------------------------
"   VimShell
"-----------------------------------------------------------------------------
let g:vimshdic = {
      \ "ruby": ["ruby", "irb"],
      \ "scheme": ["scheme", "PAGER=cat gosh -i"]
      \ }

function! FtOpenVimsh(ft)
  let a = g:vimshdic[a:ft]
  call OpenVimsh(a[0], a[1])
endfunction

function! OpenVimsh(bufname, cmd)
  if exists("g:vimsh_split_open")
    let sp_save = g:vimsh_split_open
  endif
  let g:vimsh_split_open = 0

  new
  if !exists("g:vimsh_loaded_python_file")
    exe "runtime " . g:vimsh_script_path
  endif
  exe "VimShNewBuf " . a:bufname
  call VimshExecCmd(a:bufname, a:cmd)

  if exists("sp_save")
    let g:vimsh_split_open = sp_save
  endif
endfunction

function! VimshExecCmd(bufname, cmd)
  let oldwinnr = winnr()
  call SingletonBuffer("_".a:bufname."_", 1)
  let g:cmd = 'python lookup_buf("_' . a:bufname . '_").execute_cmd([vim.eval("a:cmd")])'
  exe g:cmd
  let g:cmd = a:cmd
  exe oldwinnr . "wincmd w"
endfunction

