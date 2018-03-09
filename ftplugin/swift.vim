let b:prettier_ft_default_args = {
  \ 'parser': 'swift',
  \ }

augroup Prettier
  autocmd!
  if g:prettier#autoformat
    autocmd BufWritePre *.swift call prettier#Autoformat()
  endif
augroup end


