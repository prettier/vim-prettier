let b:prettier_ft_default_args = {
  \ 'parser': 'scss',
  \ }

augroup Prettier
  autocmd!
  if g:prettier#autoformat
    autocmd BufWritePre *.scss call prettier#Autoformat()
  endif
augroup end
