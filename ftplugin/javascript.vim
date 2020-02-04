augroup Prettier
  autocmd!
  if get(g:, 'prettier#autoformat')
    autocmd BufWritePre *.js,*.jsx,*.mjs call prettier#Autoformat()
  endif
augroup end
