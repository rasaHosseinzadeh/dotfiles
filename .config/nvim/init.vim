set number relativenumber
syntax on
set linebreak
set textwidth=100
set showmatch
set visualbell
set splitbelow splitright
set wildmode=longest,list,full

"Split move keys
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" ###############

set hlsearch
set smartcase
set ignorecase
set incsearch
 
set autoindent
set cindent
set expandtab
set shiftwidth=4
set smartindent	
set smarttab
set softtabstop=4
 
 
set t_Co=256
set undolevels=1000
set backspace=indent,eol,start
 
set cursorline

call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex'
Plug 'preservim/nerdtree'
Plug 'rakr/vim-one'
Plug 'Shougo/deoplete.nvim'
Plug 'tbodt/deoplete-tabnine'
call plug#end()


"############################
" Airline Config
"let g:airline#extensions#tabline#enabled = 1
let g:airline_theme= 'deus'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'default'

"############################

" Vim-One Theme
set termguicolors
colorscheme one
set background=dark
hi Normal guibg=NONE ctermbg=NONE
" ###################


"  Vim-Tex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
"############################


" Spell checker
setlocal spell
set spelllang=en_us
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>
"inoremap /C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
" #############################

" Mouse Support
set mouse=a
" ####################


"Auto Complete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"####################

" Copy Paste Support
set clipboard=unnamedplus
" ##########################
