" Basic
set encoding=utf-8

" UI
set number
set showmatch
set wildmenu
set laststatus=2
set showcmd
set scrolloff=5

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase
nnoremap <silent> <Esc> :nohlsearch<CR>

" Indent
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Behavior
set backspace=indent,eol,start
set autoread
set mouse=a
set clipboard=unnamedplus

" No swap/backup clutter
set noswapfile
set nobackup
set nowritebackup

" Leader
let mapleader = " "

" Keymaps
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move lines up/down in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep visual selection after indent
vnoremap < <gv
vnoremap > >gv

" Syntax & filetype
syntax on
filetype plugin indent on

" Colors
set termguicolors
set background=dark
colorscheme onedark
