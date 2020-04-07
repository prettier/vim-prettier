let b:prettier_ft_default_args = {
  \ 'parser': 'scss',
  \ }

augroup Prettier
  autocmd!
  autocmd BufWritePre *.scss call prettier#Autoformat()
augroup end
