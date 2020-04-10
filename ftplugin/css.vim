let b:prettier_ft_default_args = {
  \ 'parser': 'css',
  \ }

augroup Prettier
  autocmd!
  autocmd BufWritePre *.css call prettier#Autoformat()
augroup end
