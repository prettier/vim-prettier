let b:prettier_ft_default_args = {
  \ 'parser': 'graphql',
  \ }

augroup Prettier
  autocmd!
  autocmd BufWritePre *.graphql,*.gql call prettier#Autoformat()
augroup end
