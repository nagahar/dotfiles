""""""""""""""""""""""""""""""
"Kaoriya版に添付されているプラグインの無効化
"問題があるものもあるので一律に無効化します。
"ファイルを参照(コメント部分で gf を実行)した上で、必要なプラグインは
"let plugin_..._disableの設定行をコメント化(削除)して有効にして下さい。
""""""""""""""""""""""""""""""
"$VIM/plugins/kaoriya/autodate.vim
"let plugin_autodate_disable  = 1
"$VIM/plugins/kaoriya/cmdex.vim
let plugin_cmdex_disable     = 1
"$VIM/plugins/kaoriya/dicwin.vim
let plugin_dicwin_disable    = 1
"$VIMRUNTIME/plugin/format.vim
let plugin_format_disable    = 1
"$VIM/plugins/kaoriya/hz_ja.vim
let plugin_hz_ja_disable     = 1
"$VIM/plugins/kaoriya/scrnmode.vim
let plugin_scrnmode_disable  = 1
"$VIM/plugins/kaoriya/verifyenc.vim
"let plugin_verifyenc_disable = 1

"auto recognition for character encoding
"if &encoding !=# 'utf-8'
"    set encoding=japan
"    set fileencoding=japan
"endif
"if has('iconv')
"    let s:enc_euc = 'euc-jp'
"    let s:enc_jis = 'iso-2022-jp'
"    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
"        let s:enc_euc = 'eucjp-ms'
"        let s:enc_jis = 'iso-2022-jp-3'
"    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
"        let s:enc_euc = 'euc-jisx0213'
"        let s:enc_jis = 'iso-2022-jp-3'
"    endif
"    if &encoding ==# 'utf-8'
"        let s:fileencodings_default = &fileencodings
"        let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
"        let &fileencodings = &fileencodings .','. s:fileencodings_default
"        unlet s:fileencodings_default
"    else
"        let &fileencodings = &fileencodings .','. s:enc_jis
"        set fileencodings+=utf-8,ucs-2le,ucs-2
"        if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
"            set fileencodings+=cp932
"            set fileencodings-=euc-jp
"            set fileencodings-=euc-jisx0213
"            set fileencodings-=eucjp-ms
"            let &encoding = s:enc_euc
"            let &fileencoding = s:enc_euc
"        else
"            let &fileencodings = &fileencodings .','. s:enc_euc
"        endif
"    endif
"    unlet s:enc_euc
"    unlet s:enc_jis
"endif

set clipboard+=unnamed

"set diffexpr=MyDiff()
"function! MyDiff()
"    let opt = '-a --binary '
"    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"    let arg1 = v:fname_in
"    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"    let arg2 = v:fname_new
"    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"    let arg3 = v:fname_out
"    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"    let eq = ''
"    if $VIMRUNTIME =~ ' '
"        if &sh =~ '\<cmd'
"            let cmd = '""' . $VIMRUNTIME . '\diff"'
"            let eq = '"'
"        else
"            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"        endif
"    else
"        let cmd = $VIMRUNTIME . '\diff'
"    endif
"    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction

" makeprg
set makeprg=nmake

" Tex
let g:Tex_CompileRule_dvi = 'platex --kanji=utf8 -interaction=nonstopmode -shell-escape "$*"'
let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'
let g:Tex_ViewRule_dvi = 'c:\w32tex\dviout\dviout.exe'
if has('win64')
    let g:Tex_ViewRule_pdf = 'c:\Program Files (x86)\SumatraPDF\SumatraPDF.exe'
else
    let g:Tex_ViewRule_pdf = 'c:\Program Files\SumatraPDF\SumatraPDF.exe'
endif

