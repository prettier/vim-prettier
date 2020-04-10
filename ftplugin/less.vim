let b:prettier_ft_default_args = {
  \ 'parser': 'less',
  \ }

augroup Prettier
  autocmd!
  autocmd BufWritePre *.less call prettier#Autoformat()
augroup end
