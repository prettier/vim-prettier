let b:prettier_ft_default_args = {
  \ 'parser': 'less',
  \ }

augroup Prettier
  autocmd!
  if g:prettier#autoformat
    autocmd BufWritePre *.less call prettier#Autoformat()
  endif
augroup end
