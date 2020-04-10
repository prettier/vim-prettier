let b:prettier_ft_default_args = {
  \ 'parser': 'ruby',
  \ }

augroup Prettier
  autocmd!
  autocmd BufWritePre *.ruby call prettier#Autoformat()
augroup end
