let b:prettier_ft_default_args = {
  \ 'parser': 'graphql',
  \ }

augroup Prettier
  autocmd!
  if g:prettier#autoformat
    autocmd BufWritePre *.graphql,*.gql call prettier#Autoformat()
  endif
augroup end
