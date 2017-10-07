augroup Prettier
  autocmd!
  if g:prettier#autoformat
    autocmd BufWritePre *.css call prettier#Autoformat()
  endif
augroup end
