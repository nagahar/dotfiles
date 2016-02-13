""""""""""""""""""""""""""""""
" NeoBundle
""""""""""""""""""""""""""""""
"NeoBundle Scripts-----------------------------
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=$CFGHOME/bundle/neobundle.vim

" Required:
let g:is_neobundle_installed = 1
function! IsNeobundled(bundle)
    return g:is_neobundle_installed && neobundle#is_installed(a:bundle)
endfunction

try
    call neobundle#begin(expand($CFGHOME.'/bundle/'))
    "let g:neobundle#log_filename = $CFGHOME."/neobundle.log"
catch /^Vim\%((\a\+)\)\=:E117/› " catch error E117: Unkown function
    let g:is_neobundle_installed = 0
    set title titlestring=NeoBundle\ is\ not\ installed!
endtry

if g:is_neobundle_installed
    " Let NeoBundle manage NeoBundle
    " Required:
    NeoBundleFetch 'Shougo/neobundle.vim'
    " Surround plugin
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'autodate', {'type': 'none', 'base': $CFGHOME.'/bundle/manual'}
    NeoBundle 'changelog', {'type': 'none', 'base': $CFGHOME.'/bundle/manual'}
    if g:tinyvim == 0
        NeoBundle 'tpope/vim-fugitive'
        " You can specify revision/branch/tag.
        NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
        NeoBundle 'Shougo/unite.vim'
        NeoBundle 'Shougo/vimproc.vim' , {
                    \ 'build' : {
                    \     'windows' : 'tools\\update-dll-mingw',
                    \     'cygwin' : 'make -f make_cygwin.mak',
                    \     'mac' : 'make -f make_mac.mak',
                    \     'linux' : 'make',
                    \     'unix' : 'gmake',
                    \    },
                    \ }
        NeoBundle 'Shougo/neosnippet.vim'
        NeoBundle 'Shougo/neosnippet-snippets'
        NeoBundle 'ctrlpvim/ctrlp.vim'
        NeoBundle 'flazz/vim-colorschemes'
        if has('lua')
            NeoBundle 'Shougo/neocomplete.vim'
        else
            NeoBundle 'Shougo/neocomplcache.vim'
        end

        NeoBundle 'kana/vim-operator-user' " for using vim-clang-format add@2014-12-29
        NeoBundle 'rhysd/vim-clang-format' " add@2014-12-29
        " lint
        NeoBundle 'scrooloose/syntastic'
        " To save vim session
        NeoBundle 'tpope/vim-obsession'
        " wordpress plugin
        NeoBundle 'sousu/VimRepress'
        "NeoBundle 'kovisoft/slimv'
        " markdown add@2015-04-29
        NeoBundle 'plasticboy/vim-markdown'
        " preview markdown
        NeoBundle 'kannokanno/previm'
        " Tex
        NeoBundle 'vim-scripts/TeX-9'
        NeoBundle 'vim-latex', {'type': 'none', 'base': $CFGHOME.'/bundle/manual'}
        " vimdoc_ja
        NeoBundle 'vim-jp/vimdoc-ja'
        " Open browser
        NeoBundle 'tyru/open-browser.vim'
        " Gauche
        "NeoBundle 'aharisu/vim_goshrepl'
        "NeoBundle 'aharisu/vim-gdev'
        " Gitk clone
        NeoBundle 'gregsexton/gitv.git'

        " Switch coding style
        NeoBundle 'switch_style', {'type': 'none', 'base': $CFGHOME.'/bundle/manual'}
        NeoBundle 'taglist_46', {'type': 'none', 'base': $CFGHOME.'/bundle/manual'}
        NeoBundle 'utl', {'type': 'none', 'base': $CFGHOME.'/bundle/manual'}
        NeoBundle 'xxd', {'type': 'none', 'base': $CFGHOME.'/bundle/manual'}
    endif

    " Required:
    call neobundle#end()

    " Required:
    filetype plugin indent on

    " If there are uninstalled bundles found on startup,
    " this will conveniently prompt you to install them.
    "NeoBundleCheck
endif
"End NeoBundle Scripts-------------------------

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif
" Enable snipMate compatibility feature.
"let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
"let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

"neocomplcache / neocomplete
if has('lua') && IsNeobundled('neocomplete.vim')
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
elseif IsNeobundled('neocomplcache.vim')
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
