let b:prettier_ft_default_args = {
  \ 'parser': 'html',
  \ }

augroup Prettier
  autocmd!
  if g:prettier#autoformat
    autocmd BufWritePre *.html call prettier#Autoformat()
  endif
augroup end
