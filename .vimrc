" Default settings for the editor
set selectmode=mouse
set ic
set fileformats=unix,dos,mac
set hls
set ruler
set tags=./tags
set mousef
set tabstop=4
set autoindent si
set foldmethod=syntax
set foldenable
syntax on

" Customized keystroke maps
" =========================
" Set buffer selection keystrokes
map <C-right> <ESC>:bn<CR>
map <C-left> <ESC>:bp<CR>
" Switch number on and off with Crtl-N (twice)
:nmap <C-N><C-N> :set invnumber <CR>
" Map the folding toggle function to Space key
nnoremap <space> za

" Options related to the GUI version (MacVIM)
" ===========================================
if has("gui_macvim")
	"Set some visual preferences
	"set transparency=25
	set gfn=Menlo\ Regular:h13
	set guioptions-=T
	colorscheme koehler
	" Map some gestures to tabs (MacVIM only)
	nmap <SwipeLeft> gT
	nmap <SwipeRight> gt
endif

" Set some file tpe specific options
" ==================================
if !exists("autocommands_loaded")
	let autocommands_loaded = 1
	au BufNewFile,BufRead *.pc set filetype=c
	au BufNewFile,BufRead *.spl set filetype=sql
	au BufNewFile,bufRead *.ddl set filetype=sql
endif

"   0800 774 1515 (Valeska)
