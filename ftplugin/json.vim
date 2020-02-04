let b:prettier_ft_default_args = {
  \ 'parser': 'json',
  \ }

augroup Prettier
  autocmd!
  if get(g:, 'prettier#autoformat')
    autocmd BufWritePre *.json call prettier#Autoformat()
  endif
augroup end
