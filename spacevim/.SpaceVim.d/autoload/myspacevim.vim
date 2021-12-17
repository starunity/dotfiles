function! myspacevim#before() abort
    " Auto enable Seiya with vim starts
    let g:seiya_auto_enable = 1
    " Set the <Leader> key to ';'
    let g:mapleader = ';'
    " Enable rainbow plugin
    " let g:rainbow_active = 1
    "
    "let g:translator_proxy_url = 'socks5://127.0.0.1:7891'
endfunction


function! myspacevim#after() abort
    " Settings
    " Set vim auto update time to 100ms
    set updatetime=100
    
    " Set ignore case on command mode
    set ignorecase
    " Set smart case on search
    set smartcase

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    if has("nvim-0.5.0") || has("patch-8.1.1564")
      " Recently vim can merge signcolumn and number column into one
      set signcolumn=number
    else
      set signcolumn=yes
    endif


    " Highlight Settings
    " Set Git Gutter highlight
    highlight GitGutterAdd    ctermfg=green ctermbg=none
    highlight GitGutterChange ctermfg=blue  ctermbg=none
    highlight GitGutterDelete ctermfg=red   ctermbg=none
    
    " Set startify header highlight
    highlight StartifyHeader  ctermfg=39

    " Set translator highlight
    hi def link Translator NormalFloat

    " Add nohlsearch struct key
    "let g:_spacevim_mappings.n = {'name' : '+No Settings'}
    nmap <buffer><silent> <leader>i :call mdip#MarkdownClipboardImage()<CR>
    let g:mdip_imgdir = 'images'
endfunction
