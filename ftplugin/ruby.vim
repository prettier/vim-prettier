let b:prettier_ft_default_args = {
  \ 'parser': 'ruby',
  \ }

augroup Prettier
  autocmd!
  autocmd BufWritePre *.rb,*.ruby call prettier#Autoformat()
augroup end
