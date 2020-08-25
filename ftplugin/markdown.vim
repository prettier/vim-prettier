let b:prettier_ft_default_args = {
  \ 'parser': 'markdown',
  \ }

augroup Prettier
  autocmd!
  autocmd BufWritePre *.markdown,*.md,*.mdown,*.mkd,*.mkdn call prettier#Autoformat()
augroup end
