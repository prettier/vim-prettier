augroup Prettier
  autocmd!
  if g:prettier#autoformat
    autocmd BufWritePre *.ts,*.tsx call prettier#Autoformat()
  endif
augroup end
