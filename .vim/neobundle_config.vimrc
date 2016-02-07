""""""""""""""""""""""""""""""
" vim-fugitive
""""""""""""""""""""""""""""""
if IsNeobundled('vim-fugitive')
    if has('iconv')
        set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%{fugitive#statusline()}%=[0x%{GetB()}]\ (%v,%l)/%L%8P\
    else
        set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%{fugitive#statusline()}%=\ (%v,%l)/%L%8P\
    endif
endif

""""""""""""""""""""""""""""""
" OmniCppComplete
""""""""""""""""""""""""""""""
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]


""""""""""""""""""""""""""""""
" TOhtml
""""""""""""""""""""""""""""""
"let html_number_lines = 0
"let html_no_pre = 1
"let html_use_encoding = "utfｰ8"

""""""""""""""""""""""""""""""
" vim-latex
""""""""""""""""""""""""""""""
if IsNeobundled('vim-latex')
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
endif

""""""""""""""""""""""""""""""
" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
""""""""""""""""""""""""""""""
"if !has('win32') && !has('windows')
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()
"endif
"call pathogen#infect()

""""""""""""""""""""""""""""""
" clang-format add@2014-12-27
""""""""""""""""""""""""""""""
if IsNeobundled('vim-clang-format')
    let g:clang_format#style_options = {
                \ "AccessModifierOffset" : -4,
                \ "AllowShortIfStatementsOnASingleLine" : "true",
                \ "AlwaysBreakTemplateDeclarations" : "true",
                \ "Standard" : "C++11",
                \ "BreakBeforeBraces" : "Stroustrup"}
endif

""""""""""""""""""""""""""""""
" syntastic
""""""""""""""""""""""""""""""
if IsNeobundled('syntastic')
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
endif

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

