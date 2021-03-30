" Run neomake on every write
autocmd! BufWritePost * Neomake

" Turn on eslint for typescript files
function! s:typescript_makers()
  let l:makers = ['tsc']
  if executable('eslint')
    call add(l:makers, 'eslint')
  endif
  return l:makers
endfunction

augroup typescript_makers
    autocmd!
    autocmd Filetype typescript let b:neomake_typescript_enabled_makers = s:typescript_makers()
augroup END

" Do not execute eslint from cwd
let g:neomake_javascript_eslint_maker = {
        \ 'args': ['--format=compact'],
        \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
        \   '%W%f: line %l\, col %c\, Warning - %m,%-G,%-G%*\d problems%#',
        \ 'output_stream': 'stdout',
        \ }
let g:neomake_typescript_eslint_maker = {
        \ 'args': ['--format=compact'],
        \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
        \   '%W%f: line %l\, col %c\, Warning - %m,%-G,%-G%*\d problems%#',
        \ 'output_stream': 'stdout',
        \ }

" Enable hlint for haskell files
let g:neomake_haskell_enabled_makers = []
