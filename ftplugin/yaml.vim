let b:prettier_ft_default_args = {
  \ 'parser': 'yaml',
  \ }

augroup Prettier
  autocmd!
  autocmd BufWritePre *.yaml,*.yml call prettier#Autoformat()
augroup end
