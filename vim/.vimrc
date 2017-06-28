" Start loading plugins
call plug#begin('~/.config/nvim/plugged')

" General Ruby shit
Plug 'vim-ruby/vim-ruby'

" JavaScript syntax & indentation
Plug 'pangloss/vim-javascript'

" JavaScript syntax for jsx
Plug 'mxw/vim-jsx'

" Clojure syntax & indentation
Plug 'vim-scripts/VimClojure'

" Async make. Linting mostly
Plug 'benekastah/neomake'

" Solarized color scheme
Plug 'altercation/vim-colors-solarized'

" Fuzzy file finder
Plug 'junegunn/fzf.vim'

" Git integration
Plug 'tpope/vim-fugitive'

" You Complete Me
Plug 'Valloric/YouCompleteMe'

" Vim Minimap
Plug 'severin-lemaignan/vim-minimap'

" Neomake local eslint first
Plug 'jaawerth/neomake-local-eslint-first'

" Swift Syntax
Plug 'keith/swift.vim'

" ES2015 code snippets (Optional)
Plug 'epilande/vim-es2015-snippets'
"
" " React code snippets
Plug 'epilande/vim-react-snippets'

" Ultisnips
Plug 'SirVer/ultisnips'

" Highlight, Jump and Resolve Conflict
Plug 'rhysd/conflict-marker.vim'

" Add plugins to &runtimepath
call plug#end()

" Map leader key to ,
let mapleader = ","

" Enable swapping background quickly
" http://tilvim.com/2013/07/31/swapping-bg.html
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark")<CR>

" Enable both relative number and number to turn on 'hybrid mode'
set relativenumber
set number
set ruler

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

set re=1

" Write spaces instead of tabs when hitting <tab>
set expandtab

" Write exactly 2 spaces when hitting <tab>
set tabstop=2

" Use 2 spaces for indentation
set shiftwidth=2

" Navigate to search results while typing
set incsearch

" Highlight search results
set hlsearch

" Disable escape key (use jj instead)
inoremap <esc> <NOP>
inoremap <C-\> <NOP>
inoremap jj <Esc>

" Clear search highlight
nmap <leader>l :noh<CR>

" Replace hash rockets with Ruby 1.9-style hashes
let @h = ":s/:\\([^=,'\"]*\\) =>/\\1:/g\<C-m>"

" Show whitespace characters (tabs, trailing spaces)
set list

""""""""""""""""""""""""
" PLUGIN CONFIGURATION "
""""""""""""""""""""""""

" Run neomake on every write
autocmd! BufWritePost * Neomake

" Auto trim trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Use 'bundle exec' when running rubocop in neomake
let g:neomake_ruby_rubocop_maker_exe = 'bundle exec rubocop'

" Enable JSX plugin in .js files
let g:jsx_ext_required = 0
let g:neomake_jsx_enabled_makers = ['eslint']

set background=light
colorscheme Solarized
set term=screen-256color

" Key mappings for fzf plugin
nmap <leader>t :FZF<CR>
nmap <leader>bb :Buffers<CR>

" Respect .gitignore in fzf
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'

" Set location of fzf binary for fzf.vim
set rtp+=/usr/local/opt/fzf

" Defines Find, which uses ripgreg through fzf
" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2#.5ai5ij9it
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" Shortcut for Find
nmap <leader>f :Find<space>

" Trigger configuration (Optional)
let g:UltiSnipsExpandTrigger="<C-l>"

let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
