augroup Prettier
  autocmd!
  autocmd BufWritePre *.js,*.jsx,*.mjs call prettier#Autoformat()
augroup end
