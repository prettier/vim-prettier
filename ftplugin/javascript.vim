augroup Prettier
  autocmd!
  if g:prettier#autoformat
    autocmd BufWritePre *.js,*.jsx,*.mjs call prettier#Autoformat()
  endif
augroup end
