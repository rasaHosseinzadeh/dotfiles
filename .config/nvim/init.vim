let mapleader = "\<Space>"			"Set leader to Space
set number relativenumber           "Relative line numbering
syntax enable                       "Syntax highlight
set path+=**                        "Search for file recursively
set wildmenu                        "Show menu in command mode
set wildmode=list:longest,full      "Menu completion method
command! MakeTags !ctags -R .       "Command to build tags
set foldmethod=indent				"Enable folding
set foldlevel=99

"Indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix

"Python Line length limit
au BufNewFile,BufRead *.py
    \ set textwidth=79

"C Line length limit and indentation
au BufNewFile,BufRead *.c, *.h, *.cpp, *.hpp
    \ set textwidth=79
    \ set cindent

set hidden                          "Change buffer without writing
set showmatch                       "Show matching brackets.
set linebreak
set visualbell
set smartcase
set cursorline                      "Highlight the current line
set spell                           "Spell Checker
set spelllang=en_us
set mouse=a                         "Mouse Support
set clipboard=unnamedplus           "Copy Paste Support
set splitbelow splitright



"Key mappings

"Split Moving
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

"Tab
nnoremap tn :tabnew<CR>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>

"Buffer
nnoremap <leader>b :buffers<CR>:buffer<Space>
nnoremap bk :bnext<CR>
nnoremap bj :bprev<CR>

":wq
nnoremap <leader>s :w<CR>
nnoremap <leader>w :bd<CR>
nnoremap <leader>q :q<CR>

"Comment
nnoremap <leader>% :norm i% <CR>
vnoremap <leader>% :norm i% <CR>
vnoremap <leader>/ :norm i// <CR>
nnoremap <leader>/ :norm i// <CR>
vnoremap <leader># :norm i# <CR>
nnoremap <leader># :norm i# <CR>
"Uncomment
nnoremap <leader>5 :norm ^x<CR>
vnoremap <leader>5 :norm ^x<CR>
"I hate highlight :)
nnoremap <leader>h :noh<CR>
"Reload vimrc
nnoremap <leader>rv :source<Space>$HOME/.config/nvim/init.vim<CR>


"Plugin
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'lervag/vimtex'
Plug 'rakr/vim-one'
Plug 'Valloric/YouCompleteMe'
Plug 'dense-analysis/ale'
call plug#end()


"Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"Vim-One Theme
set termguicolors
colorscheme one
set background=dark
hi Normal guibg=NONE ctermbg=NONE

"Vim-Tex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
nnoremap  <leader>lb :VimtexCompile<CR>
nnoremap  <leader>lc :VimtexClean<CR>
nnoremap  <leader>lv :VimtexView<CR>

"You Complete Me
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"Ale
let g:ale_linters = {
\   'python': ['flake8'],
\}
let g:ale_fixers = {
\    '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
nmap <leader>f :ALEFix<CR>
