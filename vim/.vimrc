" LazyVim-inspired Vim configuration with comma leader
" Simple, clean config that works with vanilla Vim

" Set leader key to comma
let mapleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" File type detection and indentation
filetype plugin indent on

" Enable mouse support
set mouse=a

" Line numbers
set number
set relativenumber

" Show current command in bottom right
set showcmd

" Highlight current line
set cursorline

" Enable 256 colors
set t_Co=256

" Use system clipboard
set clipboard=unnamedplus

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation & Tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Number of spaces for each tab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Smart indentation
set smartindent
set autoindent

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight search results
set hlsearch

" Incremental search (search as you type)
set incsearch

" Case insensitive search unless uppercase is used
set ignorecase
set smartcase

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show whitespace characters
set list
set listchars=tab:→\ ,trail:·,extends:»,precedes:«

" Always show sign column
set signcolumn=yes

" Show column at 80 characters
set colorcolumn=80

" Always show status line
set laststatus=2

" Better status line
set statusline=%f\ %m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

" Don't show mode in command line (shown in status line)
set noshowmode

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window & Buffer Management
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allow hidden buffers
set hidden

" Better window splitting
set splitbelow
set splitright

" Reduce update time
set updatetime=300

" Don't pass messages to ins-completion-menu
set shortmess+=c

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clear search highlights
nnoremap <leader>l :nohlsearch<CR>

" Better escape mapping
inoremap fd <Esc>

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize windows with arrow keys
nnoremap <Up> :resize +2<CR>
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

" Move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Better indenting in visual mode
vnoremap < <gv
vnoremap > >gv

" Save and quit shortcuts
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Buffer navigation (simple without plugins)
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bd :bdelete<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto Commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Return to last edit position when opening files
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Set proper filetype for common extensions
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Performance
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Faster scrolling
set lazyredraw

" Don't create swap files
set noswapfile

" Don't create backup files
set nobackup
set nowritebackup

" Persistent undo
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undodir
  if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
  endif
endif