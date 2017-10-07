augroup Prettier
  autocmd!
  if g:prettier#autoformat
    autocmd BufWritePre *.graphql,*.gql call prettier#Autoformat()
  endif
augroup end
