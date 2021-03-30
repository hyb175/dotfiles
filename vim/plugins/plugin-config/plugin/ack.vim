" Ack.vim config
if executable('rg')
  let g:ackprg = 'command rg --sort path --vimgrep'
endif
let g:ack_mappings = {
  \ "<C-X>": "<C-W><CR><C-W>K",
  \ "<C-V>": "<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t" }

" Search the project for a specified string
nmap <leader>g :Ack!<space>

" Search the project for the string under the cursor
nmap <leader>w :Ack!<space><cword><CR>
