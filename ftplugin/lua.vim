let b:prettier_ft_default_args = {
  \ 'parser': 'lua',
  \ }

augroup Prettier
  autocmd!
  if get(g:, 'prettier#autoformat')
    autocmd BufWritePre *.lua call prettier#Autoformat()
  endif
augroup end
