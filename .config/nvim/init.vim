set number relativenumber
set hidden
set paste
set pastetoggle=<F2>
syntax on
set linebreak
set textwidth=100
set showmatch
set visualbell
set splitbelow splitright
set wildmode=longest,list,full

"Split move keys
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" ###############
" Set Leader to Space
let mapleader = "\<Space>"

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
Plug 'easymotion/vim-easymotion' 
Plug '907th/vim-auto-save'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

"############################

" Autosave
let g:auto_save_write_all_buffers = 1  " write all open buffers as if you would use :wa
noremap <C-s> :AutoSaveToggle<CR>
"############################

" Airline Config
let g:airline#extensions#tabline#enabled = 1
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
nnoremap  lb :VimtexCompile<CR>
nnoremap  lc :VimtexClean<CR>
nnoremap  lv :VimtexView<CR>
"############################


" Spell checker
setlocal spell
set spelllang=en_us
nnoremap <silent> <F11> :set spell!<CR>
inoremap <silent> <F11> <C-O>:set spell!<CR>
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

" NerdTree
nnoremap <Leader>nd :NERDTreeToggle<CR>
" #########################

"CtrlP
nnoremap <C-b> :CtrlPBuffer<CR>
" ########################
" Easy Motion Setting
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_use_smartsign_us = 1 " US layout
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nnoremap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nnoremap <Leader>s <Plug>(easymotion-overwin-f2)
" JK motions: Line motions
noremap <Leader>k <Plug>(easymotion-k)
noremap <Leader>j <Plug>(easymotion-j)
"##########################

" Key mappings

" tab stuff
nnoremap tn :tabnew<CR>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

" buffer stuff
nnoremap <Leader>b :buffers<CR>:buffer<Space>
nnoremap bn :bnext<CR>
nnoremap bp :bprev<CR>
nnoremap bq :bd<CR>
" space-s to save
nnoremap <leader>w :w<CR>

" space-q to quit (doesn't save, watch out!)
nnoremap <leader>q :q<CR>

" Commenting

" space-% insert "%" commenting
nnoremap <leader>% :norm i%<CR>
vnoremap <leader>% :norm i%<CR>

" space-5 uncomment
nnoremap <leader>5 :norm ^x<CR>
vnoremap <leader>5 :norm ^x<CR>


" Reload vimrc
nnoremap <leader>rv :source<Space>$HOME/.config/nvim/init.vim<CR>

