augroup Prettier
  autocmd!
  if g:prettier#autoformat
    autocmd BufWritePre *.scss call prettier#Autoformat()
  endif
augroup end
