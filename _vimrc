set ic
set hls
set ruler
set tags=./tags
set mousef
set tabstop=8
set autoindent si
" set foldmethod=syntax
" set foldenable
syntax on

" Switch number on and off with Crtl-N (twice)
:nmap <C-N><C-N> :set invnumber <CR>

" Options related to the GUI version (MacVIM)
" ===========================================
if has("gui_macvim")
        "Set some visual preferences
        "set transparency=25
        set gfn=Menlo\ Regular:h13
        set guioptions-=T
        colorscheme koehler
endif
