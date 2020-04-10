let b:prettier_ft_default_args = {
  \ 'parser': 'json',
  \ }

augroup Prettier
  autocmd!
  autocmd BufWritePre *.json call prettier#Autoformat()
augroup end
