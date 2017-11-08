let b:prettier_ft_default_args = {
  \ 'parser': 'markdown',
  \ }

augroup Prettier
  autocmd!
  if g:prettier#autoformat
    autocmd BufWritePre *.markdown,*.md,*.mdown,*.mkd,*.mkdn call prettier#Autoformat()
  endif
augroup end
