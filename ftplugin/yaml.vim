let b:prettier_ft_default_args = {
  \ 'parser': 'yaml',
  \ }

augroup Prettier
  autocmd!
  autocmd BufWritePre *.yml,*.yaml call prettier#Autoformat()
augroup end
