" Map leader key to ,
let mapleader = ","

" Define ruby host
let g:ruby_host_prog='~/.asdf/shims/neovim-ruby-host'

" Enable both relative number and number to turn on 'hybrid mode'
set relativenumber
set number

" Write spaces instead of tabs when hitting <tab>
set expandtab

" Write exactly 2 spaces when hitting <tab>
set tabstop=2

" Use 2 spaces for indentation
set shiftwidth=2

" File type indentation
filetype plugin indent on

" Highlight search results
set hlsearch

" Map fd in insert mode to esc
inoremap fd <Esc>

" Map fd in terminal mode to return to normal mode
tnoremap fd <C-\><C-n>

" Show whitespace characters (tabs, trailing spaces)
set list

" Use the system clipbord as the default register
set clipboard=unnamedplus

" Allow modified buffers to be hidden (except for netrw buffers)
" https://github.com/tpope/vim-vinegar/issues/13
set nohidden
augroup netrw_buf_hidden_fix
  autocmd!

  " Set all non-netrw buffers to bufhidden=hide
  autocmd BufWinEnter *
    \  if &ft != 'netrw'
    \|   set bufhidden=hide
    \| endif
augroup end

" Fix syntax highlighting for tsx files
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

" Set the statusline of terminal buffers to the term title
autocmd TermOpen * setlocal statusline=%{b:term_title}

" Disable scrolloff because it makes curses-like programs jump around in
" terminal buffers
" https://github.com/neovim/neovim/issues/11072
set scrolloff=0

" Never show tabline
set showtabline=0

" Clear search highlight
nmap <leader>l :nohlsearch<CR>

" Always display signcolumn
set signcolumn=yes

" Open git in neovim remote
if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif

" Enable code folding
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Auto remove trailing whitespace
autocmd FileType ruby,typescript,javascript autocmd BufWritePre <buffer> %s/\s\+$//e

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN CONFIGURATION "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set prefix for FZF functions
let g:fzf_command_prefix = 'Fzf'

" Quickly switch tabs with fzf
if !exists('g:fzf_tabs_mru')
  let g:fzf_tabs_mru = {}
endif
augroup fzf_tabs
  autocmd!
  autocmd TabEnter * let g:fzf_tabs_mru[tabpagenr()] = localtime()
  autocmd TabClosed * silent! call remove(g:fzf_tabs_mru, expand('<afile>'))
augroup END

function! s:fzf_tab_sink(line)
  let list = matchlist(a:line, '^\[\([0-9]\+\)\]')
  let tabnr = list[1]
  execute tabnr . 'tabnext'
endfunction

function! s:sort_tabs_mru(...)
  let [t1, t2] = map(copy(a:000), 'get(g:fzf_tabs_mru, v:val, v:val)')
  return t1 - t2
endfunction

function! s:fzf_list_tabs(...)
  let l:tabs = []
  let l:longest_tab_number_length = 0
  let l:longest_name_length = 0

  for t in sort(range(1, tabpagenr('$')), 's:sort_tabs_mru')
    let tab_number = printf("[%d]", t)
    let pwd = getcwd(-1, t)
    let name = fnamemodify(pwd, ':t')

    let l:tab_number_length = len(l:tab_number)
    if l:tab_number_length > l:longest_tab_number_length
      let l:longest_tab_number_length = l:tab_number_length
    endif

    let l:name_length = len(l:name)
    if l:name_length > l:longest_name_length
      let l:longest_name_length = l:name_length
    endif

    let tab = {
      \ 'tab_number' : tab_number,
      \ 'directory_path' : fnamemodify(pwd, ':p:~'),
      \ 'directory_name' : name,
      \ }
    call add(l:tabs, tab)
  endfor

  let lines = []
  let l:format = "%-" . l:longest_tab_number_length . "S %-" . l:longest_name_length . "S %s"
  for tab in l:tabs
    let line = printf(l:format, tab['tab_number'], tab['directory_name'], tab['directory_path'])
    call add(lines, line)
  endfor

  return fzf#run({
  \ 'source': reverse(lines),
  \ 'sink': function('s:fzf_tab_sink'),
  \ 'down': '30%',
  \ 'options': ['--header-lines=1']
  \})
endfunction

command! -nargs=0 FzfTabs :call s:fzf_list_tabs()

" Key mappings for fzf plugin
nmap <leader>f :FzfGFiles<CR>
nmap <leader>tt :FzfFiles<CR>
nmap <leader>bb :FzfBuffers<CR>
nmap <leader>c :FzfHistory:<CR>
nmap <leader>gt :FzfTabs<CR>
" Search the project for a specified string
nmap <leader>g :FzfRg<space>
" Search the project for the string under the cursor
nmap <leader>w :FzfRg<space><cword><CR>

" delete buffer but keep window open
" https://superuser.com/questions/289285/how-to-close-buffer-without-closing-the-window
command! DeleteBufferSafely :bn|:bd#
nmap <leader>bd :DeleteBufferSafely<CR>

" Preview markdown with Glow
nmap <leader>pm :Glow<CR>

command! -nargs=0 FormatJSON '%!python -m json.tool'
nmap <leader>fj :FormatJSON<CR>

" Key mappings for NvimTree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

highlight NvimTreeFolderIcon guibg=blue

" Fix autocomplete enter not working
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
