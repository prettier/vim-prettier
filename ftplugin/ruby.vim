let b:prettier_ft_default_args = {
  \ 'parser': 'ruby',
  \ }

augroup Prettier
  autocmd!
  if get(g:, 'prettier#autoformat')
    autocmd BufWritePre *.ruby call prettier#Autoformat()
  endif
augroup end
