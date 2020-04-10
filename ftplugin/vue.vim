let b:prettier_ft_default_args = {
  \ 'parser': 'vue',
  \ }

augroup Prettier
  autocmd!
  autocmd BufWritePre *.vue call prettier#Autoformat()
augroup end
