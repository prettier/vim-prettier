augroup Prettier
  autocmd!
  if g:prettier#autoformat
    autocmd BufWritePre *.json call prettier#Autoformat()
  endif
augroup end
