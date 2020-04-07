let b:prettier_ft_default_args = {
  \ 'parser': 'php',
  \ }

augroup Prettier
  autocmd!
  autocmd BufWritePre *.php call prettier#Autoformat()
augroup end
