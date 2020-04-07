let b:prettier_ft_default_args = {
  \ 'parser': 'lua',
  \ }

augroup Prettier
  autocmd!
  autocmd BufWritePre *.lua call prettier#Autoformat()
augroup end
