augroup Prettier
  autocmd!
  if g:prettier#autoformat
    autocmd BufWritePre *.less call prettier#Autoformat()
  endif
augroup end
