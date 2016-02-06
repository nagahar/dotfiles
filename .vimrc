set guioptions+=M
set guioptions-=m
set guioptions-=T

"----------------------------------------
" system configuration
"----------------------------------------

if has('win32') || has('win64')
    let $CFGHOME=$HOME.'/vimfiles'
else
    let $CFGHOME=$HOME.'/.vim'
endif

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
let plugin_verifyenc_disable = 1

" neobundle
" Note: Skip initialization for vim-tiny or vim-small.
if !has('win32') && !has('win64')
    if !1 | finish | endif
    filetype plugin indent off     " required!
    if has('vim_starting')
        if &compatible
            set nocompatible               " Be iMproved
        endif
        set runtimepath+=$CFGHOME/bundle/neobundle.vim
    endif
    call neobundle#begin(expand($CFGHOME.'/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
    " original repos on github
    NeoBundle 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/vimproc.vim' , {
                \ 'build' : {
                \     'windows' : 'tools\\update-dll-mingw',
                \     'cygwin' : 'make -f make_cygwin.mak',
                \     'mac' : 'make -f make_mac.mak',
                \     'linux' : 'make',
                \     'unix' : 'gmake',
                \    },
                \ }
    NeoBundle 'Shougo/vimshell.vim'
    NeoBundle 'Shougo/unite.vim'
    " if_lua is true -> use neocomplete add@2015-02-07
    if has('lua')
        NeoBundle 'Shougo/neocomplete.vim'
    end
    NeoBundle 'Shougo/neocomplcache.vim'

    NeoBundle 'Shougo/neosnippet.vim'
    NeoBundle 'Shougo/neosnippet-snippets'
    NeoBundle 'honza/vim-snippets'
    "NeoBundle 'https://bitbucket.org/kovisoft/slimv' " Relplace github with bitbucket delete@2015-02-07
    NeoBundle 'kovisoft/slimv' " Manual update is needed in slime dir.
    NeoBundle 'kana/vim-operator-user' " for using vim-clang-format add@2014-12-29
    NeoBundle 'rhysd/vim-clang-format' " add@2014-12-29
    NeoBundle 'tpope/vim-fugitive'
    NeoBundle 'ctrlpvim/ctrlp.vim'
    NeoBundle 'flazz/vim-colorschemes'

    NeoBundle 'kannokanno/previm'
    NeoBundle 'tyru/open-browser.vim'
    " markdown add@2015-04-29
    NeoBundle 'plasticboy/vim-markdown'
    " wordpress plugin
    if has('mac')
        NeoBundle 'sousu/VimRepress'
    endif
    NeoBundle 'tpope/vim-obsession'


    au BufRead,BufNewFile *.md set filetype=markdown
    let g:previm_open_cmd = 'open -a Firefox'

    call neobundle#end()
    " If there are uninstalled bundles found on startup,
    " this will conveniently prompt you to install them.
    NeoBundleCheck
    filetype plugin indent on     " required!
    filetype indent on

    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    "imap <expr><TAB>
    " \ pumvisible() ? "\<C-n>" :
    " \ neosnippet#expandable_or_jumpable() ?
    " \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    "smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    "\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " For conceal markers.
    "if has('conceal')
    "  set conceallevel=2 concealcursor=niv
    "endif

    " Enable snipMate compatibility feature.
    "let g:neosnippet#enable_snipmate_compatibility = 1
    " Tell Neosnippet about the other snippets
    "let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

    "neocomplcache / neocomplete
    "if has('lua') && neobundle#is_installed('neocomplete')
    if has('lua')
        " neocomplete
        let g:acp_enableAtStartup = 0
        " Use neocomplete.
        let g:neocomplete#enable_at_startup = 1
        " Use smartcase.
        let g:neocomplete#enable_smart_case = 1
        " Set minimum syntax keyword length.
        let g:neocomplete#sources#syntax#min_keyword_length = 3
        let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

        " Define dictionary.
        let g:neocomplete#sources#dictionary#dictionaries = {
                    \ 'default' : '',
                    \ 'vimshell' : $HOME.'/.vimshell_hist',
                    \ }

        " Define keyword.
        if !exists('g:neocomplete#keyword_patterns')
            let g:neocomplete#keyword_patterns = {}
        endif
        let g:neocomplete#keyword_patterns['default'] = '\h\w*'

        " Plugin key-mappings.
        inoremap <expr><C-g>     neocomplete#undo_completion()
        inoremap <expr><C-l>     neocomplete#complete_common_string()

        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
            return neocomplete#close_popup() . "\<CR>"
            " For no inserting <CR> key.
            "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
        endfunction
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplete#close_popup()
        inoremap <expr><C-e>  neocomplete#cancel_popup()

        " Enable heavy omni completion.
        if !exists('g:neocomplete#sources#omni#input_patterns')
            let g:neocomplete#sources#omni#input_patterns = {}
        endif
    else
        " neocomplcache
        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_enable_ignore_case = 1
        let g:neocomplcache_enable_smart_case = 1
        if !exists('g:neocomplcache_keyword_patterns')
            let g:neocomplcache_keyword_patterns = {}
        endif
        let g:neocomplcache_keyword_patterns._ = '\h\w*'
        let g:neocomplcache_enable_camel_case_completion = 1
        let g:neocomplcache_enable_underbar_completion = 1
        "inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>" "delete@2015-02-07
        "inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
        "inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
    endif
endif

"set nocompatible
set complete+=k
set browsedir=buffer


" add@2016-02-06
set fileencodings=iso-2022-jp-3,iso-2022-jp,euc-jisx0213,euc-jp,utf-8,ucs-bom,euc-jp,eucjp-ms,cp932
if has('win32') || has('win64')
    set encoding=cp932
endif
" delete@2016-02-06
" auto recognition for character encoding
"if has('win32') || has('win64')
"    set enc=utf-8
"endif
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

if has('autocmd')
    function! AU_ReCheck_FENC()
        if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
            let &fileencoding=&encoding
        endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
endif

set fileformats=unix,dos,mac
if exists('&ambiwidth')
    set ambiwidth=double
endif

" backup
"if has('win32')
"	set directory=$TMP
"	set backupdir=$TMP
"else
"	set directory=$HOME/.vimbackup
"	set backupdir=$HOME/.vimbackup
"endif

set nobackup
set noswapfile
set nowritebackup

"viminfo
"set viminfo=

if has('win32') || has('win64') || has('mac')
    " shared clipboard
    set clipboard+=unnamed
endif

" change directory automaticaly for rgrep,tags
"set autochdir
if has("autochdir")
    " moive directory in editing
    set autochdir
    set tags=tags;
else
    set tags=./tags,./../tags,./*/tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags
endif
" unset octal number
set nrformats-=octal
" time to type key
set timeoutlen=3500
" don't display message in opening
set hidden
" the number of history
set history=1000
" the number of undo
set undolevels=1000
" valid free cursur in visual block
set virtualedit=block
" move start/end of line by cursur
set whichwrap=b,s,h,l,[,],<,>
" valid backspace
set backspace=indent,eol,start
" complete command line
set wildmenu
" valid mouse
if has('mouse')
    set mouse=a
    "  behave mswin
endif

" foldmethod
set foldmethod=syntax

" ctags
if has('win32') || has('win64')
    let Tlist_Ctags_Cmd = 'c:\ctags\ctags.exe'
endif

"----------------------------------------
" display configuration
"----------------------------------------
"colorscheme mycolor
"colorscheme desert
"colorscheme desertExMe
if has('win32') || has('win64')
    "colorscheme desert
else
    colorscheme mrkn256
    "colorscheme desert
endif


" don't display splash
set shortmess+=I
" no bell
set noerrorbells
set novisualbell
set visualbell t_vb=
set lazyredraw
" allow '/' as the directory separator in Windows
set shellslash
" print line number
set number
" time of match
set showmatch matchtime=1
" height of command
set cmdheight=2
" print command on status
set showcmd
" print title
set title
" print character encoding on status
set laststatus=2
if has('iconv')
    set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%{fugitive#statusline()}%=[0x%{GetB()}]\ (%v,%l)/%L%8P\ 
else
    set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%{fugitive#statusline()}%=\ (%v,%l)/%L%8P\ 
endif

set display=lastline
" valid highlight
if &t_Co > 2 || has('gui_running')
    "syntax on
    set hlsearch
endif

set showtabline=1

"----------------------------------------
" coding style
"----------------------------------------
" textwidth
set textwidth=1000
autocmd BufRead *.{c,cpp,h,cs,js,java,hs,lisp,scm,rb,pl,py,php,sh,md,css,vim} set tw=80

" remove space in concatenating in Japanese
set formatoptions+=mM

" tab
" Use space 4 change@2014-12-27
set tabstop=4 shiftwidth=4 softtabstop=0
set shiftround
set expandtab

" indent
set autoindent
set smartindent
"set cindent
set cinoptions+=:0

"----------------------------------------
" search
"----------------------------------------
" no case ignore
set noignorecase
"set smartcase

set wrapscan
set incsearch
"w,bの移動で認識する文字
"set iskeyword=a-z,A-Z,48-57,_,.,-,>
"vimgrep をデフォルトのgrepとする場合internal
set grepprg=internal
if has('win32') || has('win64')
    set diffexpr=MyDiff()
    function! MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

" print diff of current buffer
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" print diff by specifing the buffer number includeding '#'
command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif

set patchexpr=MyPatch()
function! MyPatch()
    :call system($VIM."\\'.'patch -o " . v:fname_out . " " . v:fname_in . " < " . v:fname_diff)
endfunction

" set 'g' option as default in using substitute
set gdefault

"----------------------------------------
" keymap
"----------------------------------------

" change the mapleader from \ to , 
let mapleader=","

"----------------------------------------
" normal mode
"----------------------------------------
" unvalide forced save command
"nnoremap ZZ <ESC>


" change Vim command mode shortcut
nnoremap ; :

" very magic as default delete@2015-05-06
"nnoremap /  /\v

" unset highlight by using <ESC><ESC>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>
nnoremap h <Left>
nnoremap j gj
nnoremap k gk
nnoremap l <Right>
nnoremap <Down> gj
nnoremap <Up>   gk
" close foldings by h at start of line
nnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'
" open foldings by l at start of line
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
" conque_term
"nnoremap <silent> H :ConqueTermVSplit zsh<CR>
" format a paragraph
nnoremap Q gqaq

" search help
nnoremap <F1> K
" Open and close the NERD_tree.vim separately
nnoremap <F2> :TrinityToggleNERDTree<CR>
nnoremap <F3> :source %<CR>
"nnoremap <F4> :runtime macros/vimsh.vim<CR>
" Open and close the srcexpl.vim separately
nnoremap <F10> :TrinityToggleSourceExplorer<CR>
" Open and close the taglist.vim separately
nnoremap <F11> :TrinityToggleTagList<CR>
" Open and close all the three plugins on the same time
nnoremap <F12> :TrinityToggleAll<CR>
" build tags of your own project with Ctrl-F12
nnoremap <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" open new file
"nnoremap <Leader>o :CtrlP<CR>

" spell check add@2016-01-19
nnoremap <silent> <leader>sc :<C-u>setlocal spell! spelllang=en_us<CR>:setlocal spell?<CR>
"  save
nnoremap <leader>w :w<CR>

" Toggle auto formatting:
nnoremap <leader>C :ClangFormatAutoToggle<CR>

" make
nnoremap <leader>m :w<CR>:make<CR>
nnoremap <F5> :make run<CR>
inoremap <F5> :make run<CR>

" Quickfix
nnoremap <leader>cp :cprevious<CR>
nnoremap <leader>cl :clist<CR>
nnoremap <leader>cn :cnext<CR>

" locationlist
nnoremap <leader>lp :lprevious<CR>
nnoremap <leader>ln :lnext<CR>

" window
nnoremap <leader>swh :topleft  vnew<CR>
nnoremap <leader>swl :botright vnew<CR>
nnoremap <leader>swk :topleft  new<CR>
nnoremap <leader>swj :botright new<CR>

" buffer
nnoremap <leader>sh :leftabove  vnew<CR>
nnoremap <leader>sl :rightbelow vnew<CR>
nnoremap <leader>sk :leftabove  new<CR>
nnoremap <leader>sj :rightbelow new<CR>

" Quickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
"nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

" utl.vim
nnoremap <silent> <leader>u :Utl<CR>
nnoremap <silent> <leader>s :Utl ol www.google.com/search?q=<C-r>/<CR>

nnoremap == gg=G2<C-o>
"" Tabs
"nnoremap <silent> <leader>tc :<C-u>tabnew<CR>:tabmove<CR>
" create temporary file as tab
nnoremap <leader>tc :<C-u>tabnew `=tempname()`<CR>


nnoremap <silent> <leader>tk :<C-u>tabclose<CR>
nnoremap <silent> <leader>tn :<C-u>tabnext<CR>
nnoremap <silent> <leader>tp :<C-u>tabprevious<CR>

"" FuzzyFinder.vim
"nnoremap <silent> <leader>fb :<C-u>FufBuffer!<CR>
"nnoremap <silent> <leader>ff :<C-u>FufFile! <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
"nnoremap <silent> <leader>fm :<C-u>FufMruFile!<CR>
"nnoremap <silent> <leader>tb :<C-u>tabnew<CR>:tabmove<CR>:FufBuffer!<CR>
"nnoremap <silent> <leader>tf :<C-u>tabnew<CR>:tabmove<CR>:FufFile! <C-r>=expand('#:~:.')[:-1-len(expand('#:~:.:t'))]<CR><CR>
"nnoremap <silent> <leader>tm :<C-u>tabnew<CR>:tabmove<CR>:FufMruFile!<CR>
"

" template
nnoremap <leader>b :r $CFGHOME/template/bug.vim<CR>
nnoremap <leader>br :r $CFGHOME/template/bugr.vim<CR>
nnoremap <leader>eb :r $CFGHOME/template/ebug.vim<CR>
nnoremap <leader>co :r $CFGHOME/template/confirm.vim<CR>
nnoremap <leader>eco :r $CFGHOME/template/econfirm.vim<CR>
nnoremap <leader>f :r $CFGHOME/template/fix.vim<CR>
nnoremap <leader>fr :r $CFGHOME/template/fixr.vim<CR>
nnoremap <leader>ef :r $CFGHOME/template/efix.vim<CR>
nnoremap <leader>to :r $CFGHOME/template/todo.vim<CR>
nnoremap <leader>eto :r $CFGHOME/template/etodo.vim<CR>
nnoremap <leader>sp :r $CFGHOME/template/spec.vim<CR>
nnoremap <leader>d :exec MyDailyTemplate()<CR>
nnoremap <leader>r :exec MyWeeklyTemplate()<CR>
nnoremap <leader>min :exec MyMinutesTemplate()<CR>
nnoremap <leader>emin :exec MyEMinutesTemplate()<CR>

" vimshel
"nnoremap <silent> <leader>vs :VimShell<CR>

" date add@2014-12-29
nnoremap <leader>date <Esc>a<C-r>=strftime("%Y-%m-%d")<CR>

" reopen with UTF-8 add@2016-01-02
nnoremap <silent> <leader>e8 :e ++enc=utf-8<CR>

"----------------------------------------
" insert mode
"----------------------------------------
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap () ()<Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap <> <><Left>
" kill an input method (IME) after finishing insert mode
inoremap <ESC> <ESC>:set iminsert=0<CR>

" vimshell
inoremap <C-w><C-w> <ESC><C-w><C-w>
inoremap <C-w> <Nop>

"----------------------------------------
" visual mode
"----------------------------------------
" close foldings by h at start of line
vnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'
" open foldings by l at start of line
vnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'
" format a paragraph
vnoremap Q gq
" change Vim command mode shortcut
vnoremap ; :

vnoremap ) t)
vnoremap ( t(

" counter
vnoremap <silent> <C-a> :ContinuousNumber <C-a><CR>
vnoremap <silent> <C-x> :ContinuousNumber <C-x><CR>

command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

"----------------------------------------
" command mode
"----------------------------------------
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap w!! w !sudo tee % >/dev/null

"----------------------------------------
" motion mode
"----------------------------------------
onoremap ) t)
onoremap ( t(

" for SKK
"cnoremap <C-j> <Nop>

"----------------------------------------
" Command-line window
"----------------------------------------

nnoremap <sid>(command-line-enter) q:
xnoremap <sid>(command-line-enter) q:
nnoremap <sid>(command-line-norange) q:<C-u>

nmap : <sid>(command-line-enter)
nmap ; <sid>(command-line-enter)
xmap : <sid>(command-line-enter)
xmap ; <sid>(command-line-enter)


autocmd CmdwinEnter * call s:init_cmdwin()

function! s:init_cmdwin()
    nnoremap <buffer> q :<C-u>quit<CR>
    nnoremap <buffer> <TAB> :<C-u>quit<CR>
    inoremap <buffer><expr><CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
    inoremap <buffer><expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
    inoremap <buffer><expr><BS> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"

    " neocomplete
    inoremap <buffer><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    startinsert!
endfunction


"----------------------------------------
" Vim script
"----------------------------------------

"""""""""""""""""""""""
" To avoid using IME in normal mode
"""""""""""""""""""""""
"aug InsModeAu
"    au!
"    au InsertEnter,CmdwinEnter * set noimdisable
"    au InsertLeave,CmdwinLeave * set imdisable
"aug END

""""""""""""""""""""""""""""""
" move cursur to previouse position
""""""""""""""""""""""""""""""
augroup vimrcEx
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line('$') |
                \   exe "normal! g`\"" |
                \ endif
augroup END

""""""""""""""""""""""""""""""
" change color on status in insert mode
""""""""""""""""""""""""""""""
if has('syntax')
    augroup InsertHook
        autocmd!
        autocmd InsertEnter * highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none
        autocmd InsertLeave * highlight StatusLine guifg=darkblue guibg=darkgrey gui=none ctermfg=blue ctermbg=grey cterm=none
    augroup END
endif

""""""""""""""""""""""""""""""
" print special character
""""""""""""""""""""""""""""""
if has('syntax')
    syntax enable
    function! ActivateInvisibleIndicator()
        highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
        "Zenkaku space
        match ZenkakuSpace /　/
        "Tab and space in end of line
        set list
        set listchars=tab:^\ ,trail:~
    endfunction
    augroup InvisibleIndicator
        autocmd!
        "autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
        autocmd BufEnter * call ActivateInvisibleIndicator()
    augroup END
endif

""""""""""""""""""""""""""""""
" print character on cursur
""""""""""""""""""""""""""""""
function! GetB()
    let c = matchstr(getline('.'), '.', col('.') - 1)
    let c = iconv(c, &enc, &fenc)
    return s:String2Hex(c)
endfunction
" :help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! s:Nr2Hex(nr)
    let n = a:nr
    let r = ''
    while n
        let r = '0123456789ABCDEF'[n % 16] . r
        let n = n / 16
    endwhile
    return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! s:String2Hex(str)
    let out = ''
    let ix = 0
    while ix < strlen(a:str)
        let out = out . s:Nr2Hex(char2nr(a:str[ix]))
        let ix = ix + 1
    endwhile
    return out
endfunc

""""""""""""""""""""""""""""""
" My reporting function
""""""""""""""""""""""""""""""
func! MyDailyTemplate()
    let b:autodate_keyword_pre = '日報:'
    let b:autodate_keyword_post = '\.'
    let b:autodate_format= '%Y-%m-%d (%a)'
    r $CFGHOME/template/daily.vim
endfunc

func! MyWeeklyTemplate()
    let b:autodate_keyword_pre = '週報:'
    let b:autodate_keyword_post = '\.'
    let b:autodate_format= '%Y-%m-%d (%a)'
    r $CFGHOME/template/weekly.vim
endfunc

func! MyMinutesTemplate()
    let b:autodate_keyword_pre = '日時場所:'
    let b:autodate_keyword_post = ' @'
    let b:autodate_format= '%Y-%m-%d (%a) '
    r $CFGHOME/template/minutes.vim
endfunc

func! MyEMinutesTemplate()
    let b:autodate_keyword_pre = 'Date: '
    let b:autodate_keyword_post = '\.'
    let b:autodate_format= '%Y-%3m-%d (%a) '
    r $CFGHOME/template/eminutes.vim
endfunc

" ActionScript
au BufNewFile,BufRead *.as	set filetype=actionscript
au FileType actionscript :set dictionary=$CFGHOME/dict/actionscript.dict

" Mxml
au BufNewFile,BufRead *.mxml	set filetype=mxml

" Plantuml syntax
au BufNewFile,BufRead *.puml	setf plantuml

" ChangeLog
augroup MyChangeLog
    "autocmd!
    autocmd BufRead,BufCreate,BufNew LifeLog.txt setf changelog
augroup END

" Binary
"au BufReadPost,BufNewFile *.bin,*.exe,*.dll,*.lib,*.so setlocal filetype=xxd
augroup Binary
    au!
    au BufReadPre  *.bin,*.exe,*.dll,*.lib,*.so let &bin=1
    au BufReadPost *.bin,*.exe,*.dll,*.lib,*.so if &bin | %!xxd
    au BufReadPost *.bin,*.exe,*.dll,*.lib,*.so set ft=xxd | endif
    au BufWritePre *.bin,*.exe,*.dll,*.lib,*.so if &bin | %!xxd -r
    au BufWritePre *.bin,*.exe,*.dll,*.lib,*.so endif
    au BufWritePost *.bin,*.exe,*.dll,*.lib,*.so if &bin | %!xxd
    au BufWritePost *.bin,*.exe,*.dll,*.lib,*.so set nomod | endif
augroup END

" xmllint
if executable('xmllint')
    if has('win32') || has('win64')
        au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>null"
    else
        au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
    endif
endif

" ejs
au BufNewFile,BufRead *.ejs set filetype=html

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enbale snipMate.vim in autocomplpop.vim
" 1. add GetSnipsInCurrentScope in snipMate.vim
"fun! GetSnipsInCurrentScope()
"	let snips = {}
"	for scope in [bufnr('%')] + split(&ft, '\.') + ['_']
"		call extend(snips, get(s:snippets, scope, {}), 'keep')
"		call extend(snips, get(s:multi_snips, scope, {}), 'keep')
"	endfor
"	return snips
"endf
" 2. g:acp_behaviorSnipmateLength = 1
"let g:acp_behaviorSnipmateLength = 1
"" set my name in snipMate
"let g:snips_author = 'Takanori Nagahara'

" Tag completion
au Filetype xml inoremap <buffer> </ </<C-x><C-o>
au Filetype html inoremap <buffer> </ </<C-x><C-o>
au Filetype changelog inoremap <buffer> </ </<C-x><C-o>

" configure tags - add additional tags here or comment out not-used ones
if has('win32') || has('win64')
    set tags+=~/vimfiles/tags/cpp
else
    set tags+=~/.vim/tags/cpp
    "set tags+=~/.vim/tags/gl
    "set tags+=~/.vim/tags/sdl
    "set tags+=~/.vim/tags/qt4
end

if has('path_extra')
    set tags+=tags;
end

" omnifunc
au FileType python set omnifunc=pythoncomplete#Complete
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType xml set omnifunc=xmlcomplete#CompleteTags
au FileType php set omnifunc=phpcomplete#CompletePHP
au FileType sql set omnifunc=sqlcomplete#CompleteTags
au FileType changelog set omnifunc=htmlcomplete#CompleteTags
if has('win32') || has('win64')
    au FileType c set omnifunc=syntaxcomplete#Complete
else
    au FileType c set omnifunc=ccomplete#Complete
endif
au FileType *
            \   if &l:omnifunc == ''
            \ |   setl omnifunc=syntaxcomplete#Complete
            \ | endif

" C/C++/Objective-C add@2014-12-27
au FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
au FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
au FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
au FileType c,cpp,objc set tabstop=2 shiftwidth=2 softtabstop=0


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


" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" autocomplpop
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" TOhtml
let html_number_lines = 0
let html_no_pre = 1
let html_use_encoding = "utfｰ8"

" vim-latex
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor = 'latex'

let g:Tex_BibtexFlavor = 'jbibtex'

let g:Tex_FormatDependency_pdf = 'dvi,pdf'

let g:Tex_DefaultTargetFormat = 'pdf'

let g:Tex_GotoError = '0'

if has('win32') || has('win64')
    let g:Tex_CompileRule_dvi = 'platex --kanji=utf8 -interaction=nonstopmode -shell-escape "$*"'
    let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'
    let g:Tex_ViewRule_dvi = 'c:\w32tex\dviout\dviout.exe'
    if has('win64')
        let g:Tex_ViewRule_pdf = 'c:\Program Files (x86)\SumatraPDF\SumatraPDF.exe'
    else
        let g:Tex_ViewRule_pdf = 'c:\Program Files\SumatraPDF\SumatraPDF.exe'
    endif
elseif has('mac')
    let g:Tex_CompileRule_dvi = '/opt/local/bin/platex-utf8 -interaction=nonstopmode -shell-escape $*'
    let g:Tex_CompileRule_pdf = '/opt/local/bin/dvipdfmx $*.dvi'
    let g:Tex_ViewRule_pdf = 'open -a /Applications/Preview.app'
else
    let g:Tex_CompileRule_dvi = '/usr/local/teTeX/bin/platex --kanji=utf8 -interaction=nonstopmode -shell-escape $*'
    let g:Tex_CompileRule_pdf = '/usr/local/teTeX/bin/dvipdfmx $*.dvi'
    let g:Tex_ViewRule_pdf = '/usr/bin/evince'
endif

" vimgrep
au QuickfixCmdPost vimgrep cw

" vimsh
" in order to use VimShell delete@2015-05-06
"let g:vimsh_prompt_override = 1 "will not use normal prompt from your 'real' shell
"let g:vimsh_prompt_pty = "%m%#" "specify overriden prompt
"let g:vimsh_split_open = 1 "don't run vimsh in the current buffer
"if has('win32') || has('win64')
"    let g:vimsh_sh = "c:/cygwin/bin/zsh.exe" "shell to run within vimsh
"else
"    let g:vimsh_sh = "/bin/zsh" "shell to run within vimsh
"endif

" conque_term
"k" Enable colors. Setting this to 0 will make your terminal faster.
"klet g:ConqueTerm_Color = 1
"k" Set your terminal type. I strong recommend leaving this as vt100, 
"k" however more features may be enabled with xterm.
"klet g:ConqueTerm_TERM = 'vt100'
"k" Set buffer syntax. Conque has highlighting for MySQL, but not much else.
"klet g:ConqueTerm_Syntax = 'conque'
"k" Continue updating shell when it's not the current, focused buffer
"klet g:ConqueTerm_ReadUnfocused = 1
"k" Exit buffer with <C-w> in insert mode
"klet g:ConqueTerm_CWInsert = 1

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
"if !has('win32') && !has('windows')
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()
"endif
call pathogen#infect()

" makeprg
if has('win32') || has('win64')
    set makeprg=nmake
endif

" virtualedit
"set virtualedit=all
"if has('virtualedit') && &virtualedit =~# '\<all\>'
"	nnoremap <expr> p (col('.') >= col('$') ? '$' : '') . 'p'
"endif

" cursor
set cursorline
set cursorcolumn


" slimv
if has('mac')
    "let g:vimshell_editor_command = '/usr/local/Cellar/macvim-kaoriya/HEAD/MacVim.app/Contents/MacOS/Vim --servername=VIM --remote-tab-wait-silent'
    let g:vimshell_editor_command = '/Applications/MacVim.app/Contents/MacOS/Vim --servername=VIM --remote-tab-wait-silent'
    let g:slimv_lisp = '/usr/local/bin/ccl64'
    let g:slimv_impl = 'clozure'
    let g:slimv_preferred = 'clozure'
    let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\" to do script \"ccl64 --load ~/.vim/bundle/slimv/slime/start-swank.lisp\""'
    let g:paredit_mode = 0
endif


"cursor shape
if exists('$TMUX')
    let &t_SI = "\ePtmux;\e\e]50;CursorShape=1\x7\e\\"
    let &t_EI = "\ePtmux;\e\e]50;CursorShape=0\x7\e\\"
elseif &term =~ "screen"
    let &t_SI = "\eP\e]50;CursorShape=1\x7\e\\"
    let &t_EI = "\eP\e]50;CursorShape=0\x7\e\\"
else
    let &t_SI = "\e]50;CursorShape=1\x7"
    let &t_EI = "\e]50;CursorShape=0\x7"
endif

" clang-format add@2014-12-27
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Stroustrup"}

" set undo dirs
set undodir=$CFGHOME/undo

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
             \ "mode" : "active",
             \ "active_filetypes" : ["javascript", "json"],
             \}

au BufRead,BufNewFile *.js set tabstop=2 shiftwidth=2 softtabstop=0
au BufRead,BufNewFile *.json set tabstop=2 shiftwidth=2 softtabstop=0

